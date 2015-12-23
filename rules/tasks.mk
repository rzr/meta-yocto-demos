#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
SELF?=${CURDIR}/rules/tasks.mk

default: rule/help
	date

rule/help: ${SELF}
	@echo "# Usage:"
	@echo "# make rule/all"
	@echo ""
	@echo "# Configuration / Environement:"
	@echo "# MACHINE=${MACHINE}"
	@echo "# USER=${USER}"
	@echo "# DL_DIR=${DL_DIR}"
	@echo "# sources_dir=${sources_dir}"
	@echo "# cache_dir=${cache_dir}"
	@echo "# build_dir=${build_dir}"
	@echo "# image_dir=${image_dir}"
	@echo "# distro=${distro}"
	@echo "# conf_file=${conf_file}"
	@echo "# image=${image}"
	@echo ""
	@echo "# Existing rules :"
	@grep -o -e '^[^# 	]*:' $< | grep -v '\$$'

${tmp_dir}/%.done: %
	mkdir -p ${@D}
	touch $@

rule/all: ${tmp_dir}/rule/setup.done
	${MAKE} rule/configure rule/path rule/env/image

${repo_dir}: ${repo_file} ${repo}
	mkdir -p $@ && cd $@/.. && ${repo} init -q -u ${local_url} -b ${repo_branch} -m $<

rule/setup/repo: ${repo_file}
	date

${repo_file}: ${repo_src_file}
	mkdir -p ${@D}
	cat $< > $@
	grep ${local_url} $@ \
	|| sed -e "s|<manifest>|<manifest>\n  <remote fetch=\"${local_url}/../\" name=\"${local_name}\"/>|g" < $< > $@
	sed -e "s|<project name=\"${project_name}\" path=\"sources/${project_name}\" remote=\"${remote}\" revision=\".*\"/>|<project name=\"${project_name}\" path=\"sources/${project_name}\" remote=\"${local_name}\" revision=\"${branch}\"/>|g" -i $@
	git add $@ 
	git commit -sam "WIP: dont push"
#	cp -av $@ $<

rule/repo/file: ${repo_file}
	grep ${local_name} $<

rule/images:
	for machine in ${machines} ; do \
	for image in ${images} ; do \
	make rule/all MACHINE=$${machine} image=$${image} \
	|| echo "$${image}/$${machine}" >> tmp/fail.log ; \
	done ; \
	done ;


rule/repo/%: ${repo_dir} ${repo} 
	cd $</.. && time ${repo} ${@F} && ${repo} list

rule/setup/repo: ${repo_file}
	date
rule/error:
	$(error "${ARG}")
${sources_dir}/${distro}: rule/repo/sync
	ls $@ || make rule/error ARG="TODO: setup distro in rule/config.mk"
	@ls -l ${@}/meta

${conf_file} ${bblayers_file}: ${tmp_dir}/rule/setup.done
	@make rule/env/help

${sources_dir}: ${repo_dir}
	cd $</.. && ${repo} sync

${repo}:
	mkdir -p ${@D}
	wget -nc -O $@ ${repo_url}
	chmod u+rx $@

rule/repo: ${repo}
	${<} --help

rule/repo/dir: ${repo_dir}
	du -hsc $<

${init_build_env}: ${sources_dir}/${distro}
	ls -l ${@D}

${build_dir}: ${init_build_env}
	mkdir -p ${@D}
	cd ${<D} && ${source} ${<} ${@}
	ls ${<D}/${@F} || ln -fs ${@} ${<D}/${@F}
	ls ${@} || ln -fs ${<D}/${@F} ${@}
	ls ${@}/conf
	$(info "workaround a /bin/sh behaviour make sure to set SHELL=/bin/bash")

rule/init_build_env: ${init_build_env}
	ls $<

rule/bblayers: ${bblayers}
	ls $<

rule/sources: ${sources_dir}
	ls $<

rule/build: ${build_dir}
	ls $<

rule/setup: rule/build
	date

rule/configure/layer/%: % ${bblayers}
	echo "BBLAYERS += \"${CURDIR}/${<}\"" >> ${bblayers}
	echo "BBLAYERS_NON_REMOVABLE += \"${CURDIR}/${<}\"" >> ${bblayers}

rule/configure/layer/.:
	date

rule/configure: ${sources_dir} rule/configure/conf rule/configure/machine rule/configure/downloads
	for dir in . ${sources_layers} ; do make $@/layer/$${dir} ; done

# RELATIVE_DIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../..')}"
rule/path: ${bblayers}
	test -r "${<}.orig" || cp -av "${<}" "${<}.orig"
	echo "RELATIVE_DIR := \"\$${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/${bsp_relative_dir}')}\"" > "${<}.tmp"
	sed -e "s|${CURDIR}|\$${RELATIVE_DIR}|g" < "${<}.orig" >> "${<}.tmp"
	mv "${<}.tmp" "${<}"
	grep "${bsp_relative_dir}" ${bblayers}

rule/configure/machine: ${conf_file}
	sed -e "s|^MACHINE ??=.*|MACHINE ??= \"${MACHINE}\"|g" -i $<

rule/configure/downloads: ${build_dir}
	[ "" = "${DL_DIR}" ] || ln -fs "${DL_DIR}" $</downloads

rule/conf: ${conf_file}
	@ls -l $<

rule/image: ${build_dir}
	cd $< && time bitbake "${image}"

rule/env/%: ${init_build_env}
	cd ${<D} && ${source} ${<} ${build_dir} \
	&& make -C ${CURDIR} rule/${@F} ARGS="${ARGS}"

rule/bitbake: ${build_dir}
	cd $< && time ${@F} ${ARGS}

rule/clean:
	rm -rfv ${build_dir}/tmp *~ .#* 
	@echo "# make rule/{cleanall,distclean,purge} to clean more"

rule/cleanall: rule/clean
	rm -rf ${build_dir}/conf ${sources_dir}

rule/distclean: rule/cleanall
	rm -rfv repo
rule/distro: ${sources_dir}/${distro}
	grep ${<F} rules/*.mk

rule/purge: rule/distclean
	rm -rf -- ${repo_dir} build*

all: rule/all
	date

rebuild: rule/purge rule/all
	date

log/%: ${tmp_dir}
	script -e -c "${MAKE} ${@F}" ${logfile}

${tmp_dir}:
	mkdir -p $@
