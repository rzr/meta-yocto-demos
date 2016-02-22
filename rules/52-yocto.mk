#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

distro_machines_dir?=${sources_dir}/${distro}/meta/conf/machine
bsp_machines_dir?=${sources_dir}/meta-${bsp}/conf/machine/
bsp_config_file?=rules/config/bsp/${bsp}/config.mk
machine_config_file?=rules/config/machine/${MACHINE}/config.mk

rule/setup-machine/%: rules/config/machine/%/config.mk GNUmakefile
	@echo "MACHINE?=${@F}" > ${local_file}
	@echo "distro?=${distro}" >> ${local_file}
	@${MAKE} GNUmakefile
	@${MAKE} rule/overide/cleanall rule/overide/reset MACHINE=${@F}
	grep MACHINE  ${local_file}
	unset MACHINE ; make rule/print | grep MACHINE | grep ${@F}


${local_file}/rule-rm:
	rm -fv ${@D}

rule/set-machine:
	${MAKE} rule/overide/machine-file MACHINE=${MACHINE} bsp=${bsp}
	grep "${MACHINE}" ${local_file}
	cp -av GNUmakefile Makefile
	-git add Makefile
	${MAKE} print | grep "MACHINE=${MACHINE}"

#rule/machine-file: ${local_file}

rule/machine-file: ${machine_config_file}
	@echo "include $<" > ${local_file}
	grep "${MACHINE}" ${local_file}

${local_file}: ${machine_config_file}
	@echo "include $<" > $@

${machine_config_file}:
	  mkdir -p ${@D}
	  echo -e "bsp?=${bsp}\nMACHINE?=${machine}" > $@

rule/scan-bsp: ${bsp_machines_dir}
	ls $</*.conf | sed -e 's|.*/\(.*\).conf|\1|g' \
 | while read machine ; do \
  ${MAKE} rule/overide/set-machine MACHINE=$${machine} ;\
 done

rule/setup-scan-bsp: ${bsp_config_file}
	rm -rf rules/config/machine/tmp
	mkdir -p rules/config/machine/ sources-tmp
	ln -fs ${CURDIR}/${<D} rules/config/machine/tmp
	ln -fs ${CURDIR}/${<D}/default.xml sources-tmp/
	${MAKE} print rule/overide/scm-repo-sync rule/overide/scan-bsp \
 MACHINE=tmp bsp=${bsp}
	rm -rf rules/config/machine/tmp

rule/setup-bsp: print rule/overide/setup-scan-bsp
	grep machine  ${local_file}

${bsp_machines_dir}: ${sources_dir}
	ls $@

${machines_list}:
	${MAKE} rule/build-machine/${@F}


rule/bsp: rule/overide/setup-bsp
	${MAKE} print
	${MAKE} rule/overide/build-machines-bsp

rule/bsp/%:
	-rm -v ${local_file}
	${MAKE} ${@D} bsp=${@F}

rule/bsps: ${tmp_dir}
	for bsp in ${bsp_list} ; do \
	${MAKE} rule/bsp/$${bsp} ; \
	done
	-rm -rf sources-tmp

rule/build-machine/%:
	grep '^MACHINE' rules/config/machine/${@F}/config.mk
	make rule/setup-machine/${@F}
	unset MACHINE ; make rule/overide/all
#	make rule/overide/images

rule/build-machines:
	for MACHINE in ${machines_list} ; do make rule/build-machine/$${MACHINE} ; done

rule/build-machines-bsp: ${bsp_machines_dir}
	ls $</*.conf | sed -e 's|.*/\(.*\).conf|\1|g' \
 | while read machine ; do \
 ${MAKE} $${machine} ; \
 done
