#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=raspberrypi
MACHINE?=${bsp}0

os?=tizen
os_profile?=common
distro?=${os}-distro
distro_branch?=${os}
extra?=
init_name?=${os}-${os_profile}
base_image?=rpi-hwup-image
image?=${base_image}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

SHELL=/bin/bash
