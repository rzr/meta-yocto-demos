#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

MACHINE?=qemux86
machine?=${MACHINE}

branch?=master
repo_branch?=${branch}
distro?=poky
init_name?=oe
image?=core-image-minimal
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

