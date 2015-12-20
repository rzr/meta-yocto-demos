#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

distro?=poky
distro_branch?=master
branch?=distro/${distro}/${distro_branch}
init_name?=oe
image_base?=core-image-minimal
image?=${image_base}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

SHELL=/bin/bash
