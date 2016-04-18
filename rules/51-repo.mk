#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

# better force in your rule/10-config.mk
SHELL?=/bin/bash

repo_file_url?=https://raw.githubusercontent.com/TizenTeam/meta-yocto-demos/master/default.xml
repo_filename=default.xml
repo_src_file?=rules/config/bsp/${bsp}/${repo_filename}
repo_dir?=${project_dir}/${sources_name}
repo_file?=${repo_dir}/${repo_filename}
local_url?=file://${repo_dir}
repo?=$(shell which repo || echo ${repo_dir}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo

rule/scm-repo-setup-bsp: ${repo_file}

#${repo_file}:
#	$(warning $@ is neeed grab sample one at ${url})
#	@echo "wget -p ${repo_file_url}"

rule/repo_file: ${repo_file}

${repo_file}: ${repo_src_file} ${repo_dir}/.git
	mkdir -p ${@D}
	@echo "TODO: ln?"
	ls $@ || ln -fs ${CURDIR}/$< $@
#	cp -av ./$< ${@} # TODO
	grep "project" "${@}"
	-cd ${@D} && git add ${@F} && git commit -m 'WIP: update ${project}' ${@F}

${repo_dir}/.git:
	@echo "log: tmp repo : $@"
	@mkdir -p ${@D}
	cd ${@D} && git init

${repo_dir}/.repo/manifest.xml: ${repo_file} ${repo}
	mkdir -p ${@D}
	cd ${@D}/.. && ls sources || ln -fs . sources 
	cd ${@D}/.. && ${repo} init -q -u ${local_url} -b ${branch} -m ${<F}
	grep project $@

rule/scm-repo/%: ${repo_dir}/.repo/manifest.xml ${repo}
	cd ${<D} && time ${repo} ${@F} && ${repo} list

rule/configure-scm-repo: ${repo_file} rule/overide/scm-repo/init rule/overide/scm-repo/sync
	date

${repo}:
	mkdir -p ${@D}
	wget -nc -O $@.tmp ${repo_url} && mv $@.tmp $@
	chmod u+rx $@

rule/repo: ${repo}
	ls ${<}
	@${<} --help

rule/scm-repo-dir: ${repo_dir}/.repo
	du -hsc $<

rule/scm-repo-sync: ${repo_dir}/.repo/manifest.xml
	-cd ${<D}/.. && git commit -m 'WIP: update ${project} ($@)' $<
	cd ${<D}/.. && time ${repo} sync --force-sync
	touch ${<D}/..

rule/scm-repo-sync-fix: ${repo_dir}/.repo/manifest.xml
	find ${<D}/.. -path '${<D}' -prune -o -type d -iname '?*?.git' | while read file ; do \
 dirname=$$(dirname -- "$${file}"); \
 basename=$$(basename -- "$${file}" | sed -e 's|.git||'); \
 ln -fvs "$${basename}.git" "$${dirname}/$${basename}" ; \
 done

#rule/overide/scm-repo/sync: rule/scm-repo-sync rule/scm-repo-sync-fix

${sources_dir}: rule/rules ${repo_file} rule/done/scm-repo-sync
	@ls -l ${@}/.repo/manifest.xml || ${MAKE} rule/done/scm-repo-sync
	touch ${@}

rule/scm-repo-clean:
	rm -rfv repo

rule/scm-repo-cleanall:
	rm -rfv repo ${repo_dir}/.repo

