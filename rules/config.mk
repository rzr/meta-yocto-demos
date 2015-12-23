#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=amlogic
MACHINE?=odroidc1

os?=tizen
os_profile?=micro
distro?=${os}-distro
distro_branch?=${os}
extra?=oic
init_name?=${os}-common
base_image?=${os}-${os_profile}-image
image?=${base_image}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

SHELL=/bin/bash

repo_dir?=${project_dir}/.repo2
build_dir=${project_dir}/build-${MACHINE}

rule/bitbake/cleanall/%: 
	${MAKE} rule/env/bitbake ARGS="-c cleanall ${@F}"

rule/bitbake/clean/%: 
	${MAKE} rule/env/bitbake ARGS="-c clean ${@F}"

rule/bitbake/task/%: 
	${MAKE} rule/env/bitbake ARGS="${@F}"

rule/bitbake/rebuild/%: rule/bitbake/cleanall/% rule/bitbake/task/%
	date

rule/test:
	make rule/bitbake/rebuild/weston MACHINE=raspberrypi2
	make rule/bitbake/rebuild/weston MACHINE=genericx86
	make rule/bitbake/rebuild/weston MACHINE=genericx86-64

images?=core-image-minimal \
 tizen-common-core-image-minimal \
 tizen-base-image
# tizen-oic-image
machines?=raspberrypi2 genericx86-64

rule/images:
	for machine in ${machines} ; do \
	for image in ${images} ; do \
	make rule/all MACHINE=$${machine} image=$${image} \
	|| echo "$${image}/$${machine}" >> tmp/fail.log ; \
	done ; \
	done ;

rule/configure/conf: ${conf_file}
	ls $<
#	echo "DISTRO_FEATURES_remove = \" x11 wayland \"" >> $<
