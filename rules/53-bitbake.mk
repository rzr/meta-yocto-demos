#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

rule/bitbake/build/%: rule/done/configure ${bblayers_file} ${conf_file}
	${MAKE} rule/env-exec/bitbake ARGS="${@F}" 

rule/bitbake/verbose/%: rule/done/configure ${bblayers_file} ${conf_file}
	${MAKE} rule/env-exec/bitbake ARGS="-v ${@F}" 

rule/bitbake-args: ${bblayers_file} ${conf_file}
	${MAKE} rule/env-exec/bitbake ARGS="${ARGS}"

rule/bitbake/cleanall/%:
	${MAKE} rule/env-exec/bitbake ARGS="-c cleanall ${@F}"

rule/bitbake/clean/%:
	${MAKE} rule/env-exec/bitbake ARGS="-c clean ${@F}"

rule/bitbake/rebuild/%: rule/bitbake/cleanall/% rule/bitbake/build/%
	@echo "log: $@: $^"

rule/print/package/%: rule/done/configure ${build_dir}/conf ${sources_dir}
	rm -f ${build_dir}/${@F}-depends.dot
	${MAKE} ${build_dir}/${@F}-depends.dot package="${@F}"
	cat ${build_dir}/${@F}-depends.dot \
	| grep -v -e '-native' \
	| grep -v digraph \
	| awk '{print $1}' | sort | uniq | grep "${@F}"
	${MAKE} ${build_dir}/${@F}-env.log package="${@F}"
	cat ${build_dir}/${@F}-env.log | grep "${@F}"

rule/print-image: rule/print/package/${image}
	@echo "log: $@: $^"

rule/list-images:
	find ${build_dir}/tmp*/deploy/images/${MACHINE}/ -type l

rule/image: rule/bitbake/build/${image} rule/override/list-images
	@echo "log: $@: $^"

${build_dir}/${package}-depends.dot: ${build_dir}/conf rule/override/sources_dir
	${MAKE} rule/env-exec/bitbake ARGS="-g ${package}"
	mv ${build_dir}/recipe-depends.dot "$@"

${build_dir}/${package}-env.log: ${build_dir}/conf rule/override/sources_dir
	${MAKE} rule/env-exec/bitbake ARGS="-e ${package}" > $@

rule/print-layers: ${build_dir}/conf ${sources_dir}
	${MAKE} rule/env-exec/bitbake-layers ARGS="show-layers"

rule/cleanall-image: rule/bitbake/cleanall/${image}
	$(info image=${image})

rule/print-images: ${conf_file}
	${MAKE} rule/env-exec/bitbake-layers ARGS='show-recipes \"*-image-*\"'
	${MAKE} rule/env-exec/bitbake-layers ARGS='show-recipes \"\*-image\"'

rule/ui-image:
	${MAKE} rule/env-exec/bitbake ARGS="${image} -g -u depexp ${@F}"

rule/ui-args:
	${MAKE} rule/env-exec/bitbake ARGS="${ARGS} -g -u depexp "

rule/show-recipes:
	${MAKE} rule/env-exec/bitbake-layers ARGS="show-recipes"

rule/run:
	${MAKE} rule/env-exec/runqemu ARGS="${MACHINE}"
