#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=raspberrypi
MACHINE?=${bsp}2

os?=tizen
os_profile?=micro
distro?=${os}-distro
distro_branch?=${os}
extra?=oic
init_name?=${os}-common
base_image?=rpi-hwup
image?=${base_image}-image-${os}-${os_profile}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

sources_layers+=sources/${os}-distro/meta-${os}/meta-${os}-${os_profile}
SHELL=/bin/bash
