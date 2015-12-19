#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=generic
MACHINE?=${bsp}x86

os?=tizen
os_profile?=common
distro?=${os}-distro
distro_branch?=${os}
init_name?=${os}-${os_profile}
image_type?=core
image?=rpi-hwup-${os}-${micro}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
