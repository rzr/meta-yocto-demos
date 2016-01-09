#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
SELF?=${CURDIR}/rules/50-tasks.mk
rules_files?=$(sort $(wildcard rules/??-*.mk))


.PHONY: rule/%

rule/default: rule/overide/help rule/overide/all
	date

rule/help: ${SELF}
	@echo "# Usage:"
	@echo "# Existing rules :"
	@grep -o -e '^[^# 	]*:' $< | grep -v '\$$' | grep -v '^rule/' | grep -v '.mk:'
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
	@echo "# More in rules/*.mk "

.FORCE: force

force:
	sync

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

${tmp_dir}/done/%:
	$(warning must define $@ explicitly else file will be removed )
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

${tmp_dir}/done/repo-sync: default.xml
	-git commit -m 'WIP: update ${project} ($@)' $<
	make rule/overide/${@F}
	mkdir -p ${@D}
	touch sources $@

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

Makefile: rules
	echo "#! /usr/bin/make -f" > $@
	for rule in ${rules_files} ; do echo "include $${rule}" >> $@ ; done

rules/80-phony.mk: $(subst rules/80-phony.mk,, ${rules_files})
	mkdir -p ${@D}
	echo '.PHONY: \' > $@
	grep '^rule/.*:' rules/*.mk | grep -v '%' | cut -d: -f2| sort | sed -e 's|$$| \\|g' >> $@
	@echo ' #eol' >> $@

rule/all: rule/done/configure rule/print/images rule/overide/image rule/list/images

rule/repo/%: ${repo_dir}/.repo ${repo}
	cd ${<D} && time ${repo} ${@F} && ${repo} list

${repo_file}:
	$(warning $@ is neeed grab sample one at ${url})
	wget -p ${repo_file_url}


rule/configure/repo: ${repo_file} rule/overide/repo/init rule/overide/repo/sync
	date

rule/rules: ${rules_files}

${repo}:
	mkdir -p ${@D}
	wget -nc -O $@ ${repo_url}
	chmod u+rx $@

${repo_dir}/.repo: ${repo_file} ${repo}
	mkdir -p $@ && cd $@/.. \
	&& ${repo} init -q -u ${local_url} -b ${branch} -m ${<F}

rule/repo: ${repo}
	ls ${<}
	@${<} --help

rule/repo-dir: ${repo_dir}/.repo
	du -hsc $<

rule/repo-sync: ${repo_dir}/.repo
	cd ${<D} && time ${repo} sync --force-sync

${sources_dir}/${distro}: rules/10-config.mk rule/overide/sources
	@ls -l ${@}/meta || make rule/error ARG="Please set distro var in $<"

rule/distro: ${sources_dir}/${distro}
	grep ${<F} rules/*.mk

${sources_dir}: rule/rules ${repo_file} rule/done/repo-sync
	@ls -l ${@} || ${MAKE} rule/repo/sync
	touch ${@}

${conf_file}: rules/90-overides.mk rules/10-config.mk rules/50-tasks.mk
	@ls $@ || make rule/done/configure
	@make rule/help

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

rule/configure: ${bblayers_file} Makefile rule/done/sub-configure-rescan rule/done/configure-conf
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
	cd ${<} && time ${@F} ${ARGS}

rule/env-exec/%: ${init_build_env}
	cd ${<D}  \
 && ${source} ${<} ${build_dir} \
 && make -C ${CURDIR} rule/exec/${@F} ARGS="${ARGS}"

rule/bitbake/task/%: rule/done/configure ${bblayers_file} ${conf_file}
	${MAKE} rule/env-exec/bitbake ARGS="${@F}"

rule/bitbake/args: ${bblayers_file} ${conf_file}
	${MAKE} rule/env-exec/bitbake ARGS="${ARGS}"

rule/bitbake/cleanall/%:
	${MAKE} rule/env-exec/bitbake ARGS="-c cleanall ${@F}"

rule/bitbake/clean/%:
	${MAKE} rule/env-exec/bitbake ARGS="-c clean ${@F}"

rule/bitbake/rebuild/%: rule/bitbake/cleanall/% rule/bitbake/task/%
	date

rule/print/package/%: rule/done/configure ${build_dir}/conf ${sources_dir}
	rm -f ${build_dir}/pn-depends.dot
	make ${build_dir}/pn-depends.dot package="${@F}"
	cat ${build_dir}/pn-depends.dot \
	| grep -v -e '-native' \
	| grep -v digraph \
	| awk '{print $1}' | sort | uniq | grep "${@F}"

rule/list/images:
	find ${build_dir}/tmp*/deploy/images/${MACHINE}/ -type l

rule/image: rule/print/image rule/bitbake/task/${image} rule/list/images
	date

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

rule/distclean: rule/overide/cleanall
	rm -rfv repo

rule/purge: rule/overide/distclean
	rm -rf -- ${repo_dir}/.repo build* tmp

rule/rebuild: rule/overide/purge rule/overide/all
	date

${build_dir}/pn-depends.dot: ${build_dir}/conf rule/overide/sources
	${MAKE} rule/env-exec/bitbake ARGS="-g ${package}"

rule/print/layers: ${build_dir}/conf ${sources_dir}
	${MAKE} rule/env-exec/bitbake-layers ARGS="show-layers"


rule/cleanall/image: rule/bitbake/cleanall/${image}

rule/print/image: rule/print/package/${image}

rule/print/images: ${build_dir}/conf ${sources_dir}
	${MAKE} rule/env-exec/bitbake-layers ARGS='show-recipes \"*-image-*\"'
	${MAKE} rule/env-exec/bitbake-layers ARGS='show-recipes \"\*-image\"'

rule/ui/image:
	${MAKE} rule/env-exec/bitbake ARGS="${image} -g -u depexp ${@F}"


rule/ui/args:
	${MAKE} rule/env-exec/bitbake ARGS="${ARGS} -g -u depexp "

rule/show-recipes:
	${MAKE} rule/env-exec/bitbake-layers ARGS="show-recipes"

#TODO/WIP
rule/show:
	${MAKE} rule/env-exec/bb ARGS="show DISTRO DISTRO_FEATURES"

rule/show-recipes:
	${MAKE} rule/env-exec/bitbake-layers ARGS="show-recipes"


# aliases

configure: rule/overide/configure

rebuild: rule/overide/rebuild
	date

all: rule/overide/all
	date

clean: rule/overide/clean

cleanall: rule/overide/cleanall

default: rule/overide/default

