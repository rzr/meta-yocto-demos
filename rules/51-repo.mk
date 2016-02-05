#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

# better force in your rule/10-config.mk
SHELL?=/bin/bash

repo_file_url?=https://raw.githubusercontent.com/TizenTeam/meta-yocto-demos/master/default.xml
repo_src_file?=default.xml
repo_dir?=${project_dir}/tmp
repo_file?=${repo_dir}/${repo_src_file}
local_url?=file://${repo_dir}
repo?=$(shell which repo || echo ${repo_dir}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo

rule/scm-repo-setup-bsp:  ${repo_dir}/${repo_src_file}

#${repo_file}:
#	$(warning $@ is neeed grab sample one at ${url})
#	@echo "wget -p ${repo_file_url}"

${repo_file}: rules/config/bsp/${bsp}/default.xml ${repo_dir}/.git
	mkdir -p ${@D}
	@echo "TODO: ln?"
	cp -av ./$< ${@}
	grep project ${@}
	-cd ${@D} && git add ${@F} && git commit -m 'WIP: update ${project}' ${@F}

${repo_dir}/.git:
	@echo "log: tmp repo"
	mkdir -p ${@D}
	cd ${@D} && git init

${repo_dir}/.repo: ${repo_file} ${repo}
	mkdir -p $@ 
	cd $@/.. && ln -fs . sources 
	cd $@/.. && ${repo} init -q -u ${local_url} -b ${branch} -m ${<F}

${tmp_dir}/done/repo-sync: ${repo_src_file} ${repo}
	-git commit -m 'WIP: update ${project} ($@)' $<
	make rule/overide/${@F}
	mkdir -p ${@D}
	touch sources $@

rule/repo/%: ${repo_dir}/.repo ${repo}
	cd ${<D} && time ${repo} ${@F} && ${repo} list


rule/configure/repo: ${repo_file} rule/overide/repo/init rule/overide/repo/sync
	date

${repo}:
	mkdir -p ${@D}
	wget -nc -O $@ ${repo_url}
	chmod u+rx $@


rule/repo: ${repo}
	ls ${<}
	@${<} --help

rule/repo-dir: ${repo_dir}/.repo
	du -hsc $<

rule/repo-sync: ${repo_dir}/.repo
	cd ${<D} && time ${repo} sync --force-sync

${sources_dir}: rule/rules ${repo_file} rule/done/repo-sync
	@ls -l ${@} || ${MAKE} rule/repo/sync
	touch ${@}

rule/scm-repo-clean:
	rm -rfv repo

rule/scm-repo-cleanall:
	rm -rfv repo ${repo_dir}/.repo

