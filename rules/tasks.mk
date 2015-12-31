#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
SELF?=${CURDIR}/rules/tasks.mk

default: rule/help rule/all
	date

rule/help: ${SELF}
	@echo "# Usage:"
	@echo "# make rule/all"
	@echo ""
	@echo "# Configuration / Environement:"
	@echo "# project_name=${project_name}"
	@echo "# branch=${branch}"
	@echo "# MACHINE=${MACHINE}"
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
	@echo "# sources_layers=${sources_layers}"
	@echo ""
	@echo "# Existing rules :"
	@grep -o -e '^[^# 	]*:' $< | grep -v '\$$'

${tmp_dir}/%.done: %
	mkdir -p ${@D}
	touch $@

rule/overide/%: %
	@echo "$@ not overidden"

rule/make/error:
	$(error "error: ${ARG}")

rule/make/rule/%:
	$(info "sub make to rescan files")
	${MAKE} ${@F} ${ARGS}

rules/config.mk:
	@echo "#distro?=TODO" > $@

rule/all: ${tmp_dir}/configure.done rule/env/image


rule/repo/%: ${repo_dir}/.repo ${repo}
	cd ${<D} && time ${repo} ${@F} && ${repo} list

rule/repo/sync: ${repo_dir}/.repo ${repo}
	cd ${<D} && time ${repo} sync && ${repo} list

rule/repo/setup: ${repo_file} rule/repo/init rule/repo/sync
	date

${repo}:
	mkdir -p ${@D}
	wget -nc -O $@ ${repo_url}
	chmod u+rx $@

${sources_dir}/${project_name}: ${sources_dir}
	ls -l $@ || ln -fs .. $@

${repo_dir}/.repo: ${repo_file} ${repo}
	mkdir -p $@ && cd $@/.. \
	&& ${repo} init -q -u ${local_url} -b ${branch} -m ${<F}

rule/repo: ${repo}
	ls ${<}
	@${<} --help

rule/repo/dir: ${repo_dir}
	du -hsc $<

${sources_dir}/${distro}: rules/config.mk 
	ls -l ${tmp_dir}/rule/repo/sync.done || make rule/repo/sync
	@ls -l ${@}/meta || make rule/make/error ARG="Please set distro var in rules/config.mk"

${sources_dir}: 
	@(warning "TODO: %@")
	ls -l ${@} || ${MAKE} rule/repo/sync 
	ls -l ${@}

${conf_file}:
	ls $@ || make ${tmp_dir}/rule/setup.done
	@make rule/env/help

${init_build_env}: ${sources_dir}/${distro}
	ls -l ${@D}

${build_dir}: ${init_build_env} ${sources_dir}/${project_name}
	mkdir -p ${build_dir}
	cd ${<D} && ${source} ${<} ${build_dir}
	ls ${<D}/${@F} || grep SHELL rules/*.mk && ln -fs ${@} ${<D}/${@F}
	ls ${@} || ln -fs ${<D}/${@F} ${@}
	ls ${@}/conf
	$(info "workaround a /bin/sh behaviour make sure to set SHELL=/bin/bash")

rule/init_build_env: ${init_build_env}
	ls $<

rule/bblayers: ${bblayers}
	ls $<

rule/sources: ${sources_dir}
	ls $< | wc -l

rule/build: ${build_dir}
	ls $<

rule/setup: rule/build
	date

rule/configure/conf: ${conf_file}
	grep -i MACHINE ${conf_file}

rule/configure/machine: ${conf_file}
	sed -e "s|^MACHINE ??=.*|MACHINE ??= \"${MACHINE}\"|g" -i $<

rule/configure/downloads: ${build_dir}
	[ "" = "${DL_DIR}" ] || ln -fs "${DL_DIR}" $</downloads

sub-rule/layer/%: %
	ls -l ${bblayers_file}
	echo "BBLAYERS += \"${CURDIR}/${<}\"" >> ${bblayers_file}
	echo "BBLAYERS_NON_REMOVABLE += \"${CURDIR}/${<}\"" >> ${bblayers_file}

sub-rule/layer/.: ${sources_dir}/${project_name}
	ls -l ${bblayers_file}
	ls -l $<

${bblayers_file}: ${tmp_dir}/sub-configure-layers.done
	grep BBLAYERS $@ | wc -l

sub-configure-layers/path: ${bblayers_file}.orig
	echo "RELATIVE_DIR := \"\$${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/${project_relative_dir}')}\"" > "${<}.tmp"
	sed -e "s|${CURDIR}|\$${RELATIVE_DIR}|g" < "${<}" >> "${<}.tmp"
	mv "${<}.tmp" "${bblayers_file}"
	grep "RELATIVE_DIR" ${bblayers_file}
#	# RELATIVE_DIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../..')}"

${bblayers_file}.orig:
	cp -av "${bblayers_file}" "${@}"

sub-configure-layers: ${conf_file}
	$(info "log: sources_layers=${sources_layers}")
	for dir in ${sources_layers} ; do make sub-rule/layer/$${dir} ; done
	${MAKE} $@/path

sub-configure-rescan: ${sources_dir} rule/configure/machine ${tmp_dir}/sub-configure-layers.done ${tmp_dir}/rule/configure/downloads.done
	$(info "log: sources_layers=${sources_layers}")
	echo "# remember dont call $@ direcly but configure"

configure: rule/sources ${tmp_dir}/rule/make/rule/sub-configure-rescan.done
	@echo "processing: $@"
	ls -l ${bblayers_file}

rule/conf: ${conf_file}
	@ls -l $<

rule/env/%: ${init_build_env}
	cd ${<D}  \
 && ${source} ${<} ${build_dir} \
 && make -C ${CURDIR} rule/${@F} ARGS="${ARGS}"

rule/bitbake: ${build_dir}
	cd $< && time bitbake ${ARGS}

rule/bitbake/task/%: ${bblayers_file} ${conf_file}
	${MAKE} rule/env/bitbake ARGS="${@F}"

rule/bitbake/cleanall/%:
	${MAKE} rule/env/bitbake ARGS="-c cleanall ${@F}"

rule/bitbake/clean/%:
	${MAKE} rule/env/bitbake ARGS="-c clean ${@F}"

rule/bitbake/rebuild/%: rule/bitbake/cleanall/% rule/bitbake/task/%
	date

rule/image: rule/bitbake/task/${image}

rule/images: ${tmp_dir}
	for machine in ${machines} ; do \
	for image in ${images} ; do \
	make rule/all MACHINE=$${machine} image=$${image} \
	|| echo "$${image}/$${machine}" >> ${tmp_dir}/fail.log ; \
	done ; \
	done ;

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
	rm -rf -- ${repo_dir}/.repo build*

all: rule/all
	date

rebuild: rule/purge rule/all
	date

log/%: ${tmp_dir}
	script -e -c "${MAKE} ${@F}" ${logfile}

${tmp_dir}:
	mkdir -p $@

