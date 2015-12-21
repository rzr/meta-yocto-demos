#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=raspberrypi
MACHINE?=${bsp}2

os?=tizen
os_profile?=common
distro?=${os}-distro
distro_branch?=${os}
extra?=oic
init_name?=${os}-${os_profile}
bsp_base_image?=rpi-hwup
base_image?=${bsp_base_image}-image-${os}-${os_profile}
image?=${base_image}-${extra}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

sources_layers+=sources/${os}-distro/meta-${os}/meta-${os}-${os_profile}
SHELL=/bin/bash
