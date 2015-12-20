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
	@echo "# conf=${conf}"
	@echo "# image=${image}"
	@echo ""
	@echo "# Existing rules :"
	@grep -o -e '^[^# 	]*:' $< | grep -v '\$$'

${tmp_dir}/%.done: %
	mkdir -p ${@D}
	touch $@

rule/all: ${tmp_dir}/rule/setup.done
	${MAKE} rule/configure rule/path rule/env/image

${repo_dir}: ${repo} ${repo_file}
	mkdir -p $@ && cd $@/.. && ${repo} init -q -u . -b ${repo_branch}

${sources_dir}/${distro}: rule/repo/sync
	ls -l ${@}/conf/combo-layer.conf

${conf} ${bblayers}: ${tmp_dir}/rule/setup.done
	@make rule/env/help

${sources_dir}: ${repo_dir}
	cd $</.. && ${repo} sync

${repo}:
	mkdir -p ${@D}
	wget -nc -O $@ ${repo_url}
	chmod u+rx $@

${init_build_env}: ${sources_dir}
	ls -l ${@D}

# workaround a /bin/sh behaviour
${build_dir}: ${init_build_env}
	mkdir -p ${@D}
	cd ${<D} && ${source} ${<} ${@}
	ls ${<D}/build || ln -fs ${@} ${<D}/build
	ls ${@} || ln -fs ${<D}/build ${@}
	ls ${@}/conf

rule/sync: ${repo_dir} ${repo} 
	cd $</.. && time ${repo} sync && ${repo} list

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

rule/configure: ${sources_dir} rule/configure/machine rule/configure/downloads
	for dir in . ${sources_layers} ; do make $@/layer/$${dir} ; done

# BSPDIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../..')}"
rule/path: ${bblayers}
	test -r "${<}.orig" || cp -av "${<}" "${<}.orig"
	echo "BSPDIR := \"\$${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/${bsp_relative_dir}')}\"" > "${<}.tmp"
	sed -e "s|${CURDIR}|\$${BSPDIR}|g" < "${<}.orig" >> "${<}.tmp"
	mv "${<}.tmp" "${<}"
	grep "${bsp_relative_dir}" ${bblayers}

rule/configure/machine: ${conf}
	sed -e "s|^MACHINE ??=.*|MACHINE ??= \"${MACHINE}\"|g" -i $<

rule/configure/downloads: ${build_dir}
	[ "" = "${DL_DIR}" ] || ln -fs "${DL_DIR}" $</downloads

rule/conf: ${conf}
	@ls -l $<

rule/image: ${build_dir}
	cd $< && time bitbake "${image}"

rule/env/%: ${init_build_env}
	cd ${<D} && ${source} ${<} ${build_dir} \
	&& make -C ${CURDIR} rule/${@F} ARGS="${ARGS}"

rule/bitbake: ${sources_dir}/${distro}/${build_dir}
	cd $< && time ${@F} ${ARGS}

rule/clean:
	rm -rfv ${build_dir}/tmp *~ .#* 
	@echo "# make rule/{cleanall,distclean,purge} to clean more"

rule/cleanall: rule/clean
	rm -rf build/conf ${sources_dir}

rule/distclean: rule/cleanall
	rm -rfv repo

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

rule/setup/repo: ${repo_file}
	date

${repo_file}: ${repo_src_file}
	mkdir -p ${@D}
	sed -e "s|<project name=\"${project_name}\" path=\"sources/${project_name}\" remote=\"${remote}\" revision=\".*\"/>|<project name=\"${project_name}\" path=\"sources/${project_name}\" remote=\"${remote}\" revision=\"${branch}\"/>|g" < $< > $@
	cp -av $@ $<
