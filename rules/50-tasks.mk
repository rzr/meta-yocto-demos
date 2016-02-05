#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
SELF?=${CURDIR}/rules/50-tasks.mk
rules_files?=$(sort $(wildcard rules/??-*.mk))

.PHONY: rule/%

rule/default: GNUmakefile rule/overide/help rule/overide/all
	date

rule/help: rule/print-env

rule/print-env: ${SELF}
	@echo "# Usage: make help"
	@echo ""
	@echo "# Existing rules :"
	@grep -o -e '^[^# 	]*:' $< \
 | grep -v '\$$' | grep -v '^rule/' | grep -v '\.mk:' | grep -v '^\.'
	@echo ""
	@echo "# Configuration / Environment:"
	@echo "# project_name=${project_name}"
	@echo "# branch=${branch}"
	@echo "# MACHINE=${MACHINE}"
	@echo "# SHELL=${SHELL}"
	@echo "# USER=${USER}"
	@echo "# email=${email}"
	@echo "# version=${version}"
	@echo "# DL_DIR=${DL_DIR}"
	@echo "# sources_dir=${sources_dir}"
	@echo "# cache_dir=${cache_dir}"
	@echo "# build_dir=${build_dir}"
	@echo "# image_dir=${image_dir}"
	@echo "# distro=${distro}"
	@echo "# conf_file=${conf_file}"
	@echo "# image=${image}"
	@echo "# images=${images}"
	@echo "# sources_layers=${sources_layers}"
	@echo "# sources_layers_conf=${sources_layers_conf}"
	@echo ""
	@echo "# More in rules/*.mk"

rule/warning:
	$(warning log: ${@F}: ${ARGS})

rule/error:
	$(error log: ${@F}: ${ARG})

rule/info:
	$(info log: ${@F}: ${ARG})

${tmp_dir}:
	mkdir -p $@

rule/overide/%: rule/%
	$(info log: info: "$<" not overidden)
	mkdir -p ${tmp_dir}/${@D}
	touch ${tmp_dir}/${@}

rule/patch/%:
	$(info no patch for $@)

${tmp_dir}/done/%:
	$(warning TODO: must define $@ explicitly else file will be removed )
	${MAKE} rule/overide/${@F}
	mkdir -p ${@D}
	touch $@

${tmp_dir}/done/sub-configure-layers:
	${MAKE} rule/overide/${@F}
	mkdir -p ${@D}
	touch $@

${tmp_dir}/done/configure:
	${MAKE} rule/overide/${@F}
	mkdir -p ${@D}
	touch $@

rule/done/%: ${tmp_dir}/done/%
	$(info log: one shot: ${@})
	mkdir -p ${<D}
	touch ${<}
	date

rule/make/%:
	$(info log: sub make to rescan files "$@")
	${MAKE} rule/${@F} ${ARGS}

rule/log/%: ${tmp_dir}
	mkdir -p ${tmp_dir}/${@D}
	script -e -c "${MAKE} rule/${@F}" ${tmp_dir}/$@

rules/10-config.mk:
	@echo "#distro?=TODO" > $@

GNUmakefile: ${rules_files}
	echo "#! /usr/bin/make -f" > $@
	for rule in ${rules_files} ; do echo "include $${rule}" >> $@ ; done

rules/80-phony.mk: $(subst rules/80-phony.mk,, ${rules_files})
	mkdir -p ${@D}
	echo '.PHONY: \' > $@
	grep '^rule/.*:' rules/*.mk | grep -v '%' | cut -d: -f2| sort | sed -e 's|$$| \\|g' >> $@
	@echo ' #eol' >> $@

rule/all: rule/done/configure rule/print/images rule/overide/image rule/list/images


rule/rules: ${rules_files}


${sources_dir}/${distro}: rules/10-config.mk rule/overide/sources
	@ls -l ${@}/meta || make rule/error ARG="Please set distro var in $<"

rule/distro: ${sources_dir}/${distro}
	grep ${<F} rules/*.mk


${conf_file}: rules/90-overides.mk rules/10-config.mk rules/50-tasks.mk
	@ls $@ || make rule/done/configure

${init_build_env}: ${sources_dir}/${distro}
	ls -l ${@D}

${build_dir}/conf:
	${MAKE} rule/init_env
	grep BBLAYERS ${@}/bblayers.conf

#${sources_dir}/${project_name}: ${sources_dir}
#	ls -l $@ || ln -fs .. $@

${build_dir}: ${init_build_env} rule/overide/init_env
	ls ${<D}/${@F} || grep SHELL rules/*.mk && ln -fs ${@} ${<D}/${@F}
	ls ${@} || ln -fs ${<D}/${@F} ${@}
	$(info log: workaround a /bin/sh behaviour make sure to set SHELL=/bin/bash)

rule/init_env: ${init_build_env}
	mkdir -p ${build_dir}
	cd ${build_dir}/.. && ${source} ${<} ${build_dir}
	grep '^MACHINE.*' ${build_dir}/conf/local.conf

rule/init_build_env: ${init_build_env}
	ls $<

rule/bblayers: ${bblayers}
	ls $<

rule/sources: ${sources_dir}
	ls $< | wc -l

rule/build: ${build_dir}
	ls $<

rule/configure-conf: rule/conf ${rules_files} 
	grep -i MACHINE ${conf_file}

rule/configure-machine: ${conf_file}
	sed -e "s|^MACHINE ??=.*|MACHINE ??= \"${MACHINE}\"|g" -i $<

rule/configure-bsp: ${conf_file}
	sync

${build_dir}/downloads: ${build_dir}
	[ "" = "${DL_DIR}" ] || ln -fs "${DL_DIR}" ${build_dir} || mkdir -p $@

rule/configure-downloads: ${build_dir}/downloads

${bblayers_file}:  ${bblayers_file}.mine
	echo "RELATIVE_DIR := \"\$${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/${project_relative_dir}')}\"" > "${@}"
	sed -e "s|${CURDIR}|\$${RELATIVE_DIR}|g" < "${<}" >> "$@"
# RELATIVE_DIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../..')}"

rule/sub-rule/layer/%: %
	echo "BBLAYERS += \"${CURDIR}/${<}\"" >> ${bblayers_file}.tmp
	echo "BBLAYERS_NON_REMOVABLE += \"${CURDIR}/${<}\"" >> ${bblayers_file}.tmp

rule/sub-rule/layer/.: .
	echo "BBLAYERS += \"${CURDIR}/${<}\"" >> ${bblayers_file}.tmp
	echo "BBLAYERS_NON_REMOVABLE =+ \"${CURDIR}/${<}\"" >> ${bblayers_file}.tmp

rule/sub-configure-layers: ${bblayers_file}.orig
	$(info log: sources_layers=${sources_layers})
	echo "# generated by $@" > ${bblayers_file}.tmp
	for dir in ${sources_layers} ; do make rule/sub-rule/layer/$${dir} ; done

rule/sub-configure-rescan: rule/overide/sources rule/overide/configure-machine rule/done/sub-configure-layers rule/overide/configure-downloads
	$(info log: sources_layers=${sources_layers})
	$(info # remember dont call $@ direcly but configure)

${bblayers_file}.mine: ${bblayers_file}.orig
	cat $< > $@.tmp
	make rule/done/sub-configure-layers
	cat ${bblayers_file}.tmp >> $@.tmp #
	mv $@.tmp $@
	grep BBLAYERS $@ | wc -l

${bblayers_file}.orig: rules/10-config.mk ${SELF}
	$(info log: keep untouched bblayers_file)
	@ls ${bblayers_file} || make rule/init_env
	mv "${bblayers_file}" "${@}"

rule/configure: ${bblayers_file} GNUmakefile rule/done/sub-configure-rescan rule/done/configure-conf
	grep 'BBLAYERS +=' $<

rule/conf: ${conf_file}
	grep '^MACHINE.*' $<
	grep ${MACHINE} $<

rule/env/%: ${init_build_env} 
	grep ${MACHINE} ${conf_file}
	cd ${<D}  \
 && ${source} ${<} ${build_dir} \
 && make -C ${CURDIR} rule/${@F} ARGS="${ARGS}"

rule/exec/%: ${build_dir} ${conf_file} ${bblayers_file}
	grep '^MACHINE.*' $</conf/local.conf
	cd ${<} && time ${@F} ${EXTRA_ARGS} ${ARGS}

rule/env-exec/%: ${init_build_env}
	cd ${<D}  \
 && ${source} ${<} ${build_dir} \
 && make -C ${CURDIR} rule/exec/${@F} ARGS="${ARGS}"

rule/images: ${tmp_dir}
	for image in ${images} ; do \
	make rule/all image=$${image} \
	|| echo "$${image}/$${machine}" >> ${tmp_dir}/fail.log ; \
	done ; \

rule/machines: ${tmp_dir}
	for machine in ${machines} ; do \
	make rule/all MACHINE=$${machine} \
	|| echo "$${image}/$${machine}" >> ${tmp_dir}/fail.log ; \
	done ;

rule/configs: ${tmp_dir}
	for machine in ${machines} ; do \
	make rule/images MACHINE=$${machine} \
	|| echo "$${image}/$${machine}" >> ${tmp_dir}/fail.log ; \
	done ;

rule/clean:
	rm -rfv ${build_dir}/tmp *~ .#*
	$(info # make rule/{cleanall,distclean,purge} to clean more)

rule/cleanall: rule/overide/clean
	rm -rf ${build_dir}/conf ${sources_dir} ${tmp_dir}

rule/distclean: rule/overide/cleanall rule/scm-${scm}-clean

rule/clean-bsp:
	$(info to be overiden in include/bsp/${bsp})

rule/purge: rule/overide/distclean rule/scm-${scm}-cleanall
	rm -rf --  build* tmp

rule/rebuild: rule/overide/purge rule/overide/all
	date


rule/build-packages: rule/overide/build-packages
	$(info to overloaded $@)

rule/clean-packages: rule/overide/clean-packages
	$(info to overloaded $@)

rule/rebuild-packages: rule/clean-packages rule/build-packages
	sync

rule/print/image: rule/print/package/${image}
	sync


rules/include/machine/%.mk:
	$(error please create $@)

rules/config/bsp/${bsp}/default.xml:
	$(error please create $@)


rule/setup-bsp: rule/overide/scm-${scm}-setup-bsp


rules/09-local-config.mk:
	touch $@

rule/setup-machine/%: rules/config/machine/%/config.mk GNUmakefile
	echo "MACHINE?=${@F}" > rules/09-local-config.mk
	echo 'include $<' >> rules/09-local-config.mk
	${MAKE} GNUmakefile
	${MAKE} rule/cleanall rule/setup-bsp rule/reset MACHINE=${@F}
	grep MACHINE rules/09-local-config.mk
	unset MACHINE ; make rule/print-env | grep MACHINE | grep ${@F}

machines_list?=$(shell ls rules/config/machine/ | sed -e 's|.mk||g' | grep -v '~' | sort) 

rule/overide/help: 
	@echo "# "
	@echo "# Usage: make \$${MACHINE}"
	@echo "# Where \$${MACHINE} is set to name of supported ones:"
	@echo "# ${machines_list}"
	@echo "# "


${machines_list}:
	${MAKE} rule/build-machine/${@F}

rule/build-machine/%:
	grep '^MACHINE' rules/config/machine/${@F}/config.mk 
	make rule/setup-machine/${@F} 
	unset MACHINE
	make rule/image
	make rule/images

rule/build-machines:
	for MACHINE in ${machines_list} ; do make rule/build-machine/${MACHINE} ; done

rule/reset:
	make GNUmakefile

rule/compress:
	find build* -type f \
	-iname "*.hddimg" -o \
	-iname "*.rpi-sdimg" | while read file ; do \
	time qemu-img convert -p -c -O qcow2 "$${file}" "$${file}.qcow2" \
        && md5sum "$${file}.qcow2" | tee "$${file}.qcow2.txt" ; \
	done
