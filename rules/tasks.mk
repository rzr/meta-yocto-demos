#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
SELF?=${CURDIR}/rules/tasks.mk

rule/help: ${SELF}
	@echo "Usage: "
	@echo "# make rule/all"
	@echo "USER=${USER}"
	@echo "BBLAYERS=${BBLAYERS}"
	@echo "image_dir=${image_dir}"
	@echo "sources_dir=${sources_dir}"
	@echo "distro=${distro}"
	@echo "# existing rules"
	@grep -o -e '^.*:' $<

${done_dir}/%.done: %
	mkdir -p ${@D}
	touch $@

rule/all: ${done_dir}/rule/setup.done
	${MAKE} rule/configure rule/env/image

${repo_dir}: ${repo} default.xml
	mkdir -p $@ && cd $@/.. && ${repo} init -u . -b ${repo_branch}

${sources_dir}/${distro}: rule/sync

${bblayers} ${conf}: ${init_build_env}
	@make rule/env/help

${sources_dir}: ${repo_dir}
	cd $</.. && ${repo} sync

${repo}:
	mkdir -p ${@D}
	curl ${repo_url} > $@
	chmod u+rx $@

${init_build_env}: ${sources_dir}

${build_dir}: ${init_build_env}
	cd ${<D} && ${source} ${<} ${build_dir}

rule/sync: ${repo_dir} ${repo} 
	cd $</.. && time ${repo} sync && ${repo} list

rule/init_build_env: ${init_build_env}

rule/bblayers: ${bblayers}

rule/sources: ${sources_dir}

rule/build: ${build_dir}


rule/setup: rule/build

rule/configure/layer/%: % ${bblayers}
	echo "BBLAYERS += \"${CURDIR}/${<}\"" >> ${bblayers}
	echo "BBLAYERS_NON_REMOVABLE += \"${CURDIR}/${<}\"" >> ${bblayers}

rule/configure/layer/.:

rule/configure: ${sources_dir} rule/configure/machine
	for dir in . ${sources_layers} ; do make $@/layer/$${dir} ; done

rule/configure/machine: ${conf}
	sed -e "s|^MACHINE ??=.*|MACHINE ??= \"${MACHINE}\"|g" -i $<


rule/image: ${build_dir}
	cd $< && time bitbake "${image}"

rule/env/%: ${init_build_env}
	cd ${<D} && ${source} ${<} ${build_dir} \
	&& make -C ${CURDIR} rule/${@F} ARGS="${ARGS}"

rule/bitbake: ${sources_dir}/${distro}/${build_dir}
	cd $< && time ${@F} ${ARGS}

rule/clean:
	rm -rfv ${build_dir}/tmp *~

rule/distclean: rule/clean
	rm -rfv .#*
	@echo "# make rule/purge to clean more"

rule/purge: rule/distclean
	rm -rf -- ${repo_dir} ${sources_dir} build* tmp repo

