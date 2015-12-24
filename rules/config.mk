#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

root_bsp=intel
bsp?=fri2
MACHINE?=${bsp}-noemgd

os?=tizen
os_profile?=micro
distro?=${os}-distro
distro_branch?=${os}
extra?=oic
init_name?=${os}-common
base_image?=${os}-${os_profile}-image
image?=tizen-core-image-minimal
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


rule/configure/conf: ${conf_file}
	ls $<

sources_layers+=sources/meta-${root_bsp}/meta-${bsp}
