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

rule/all: rule/configure rule/env/image


test: rule/tmp.done

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

rule/build_dir: ${build_dir}

rule/configure/machine:

rule/configure: rule/configure/machine

rule/setup: ${sources_dir}
	for dir in $(wildcard sources/* | sort) ; do make rule/$${dir}/configure ; done

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

