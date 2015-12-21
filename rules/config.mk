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
base_image?=wetek-image-minimal
image?=tizen-base-image
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

sources_layers+=sources/${os}-distro/meta-${os}/meta-${os}-${os_profile}
SHELL=/bin/bash

rule/configure/conf: ${conf_file}
	echo "DISTRO_FEATURES_remove = \" x11 wayland \"" >> $<
