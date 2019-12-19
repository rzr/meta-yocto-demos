#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

rule/override/%: rule/%
	$(info log: info: "$@: $<" not overridden)
	@mkdir -p ${task_dir}/${@D}
	@touch ${task_dir}/${@}

${task_dir}/rule/done/%:
	$(warning TODO: must define $@ explicitly else file will be removed )
	${MAKE} rule/override/${@F}
	mkdir -p ${@D}
	touch $@

rule/patch/%: ${build_dir}/%
	$(info no patch for $@)
