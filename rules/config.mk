#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=generic
MACHINE?=${bsp}x86

os?=tizen
extra?=oic
os_profile?=common
distro?=${os}-distro
init_name?=${os}-${os_profile}
image_type?=${extra}
image?=${os}-${image_type}-image
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

