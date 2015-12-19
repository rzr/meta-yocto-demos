#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=raspberrypi
MACHINE?=${bsp}2

os?=tizen
os_profile?=common
distro?=${os}-distro
distro_branch?=${os}
init_name?=${os}-${os_profile}
image_type?=core
base_image?=rpi-hwup-image
image_os_profile?=micro
image?=${base_image}-tizen-micro
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
build_dir?=${sources_dir}/${distro}/build
local_build_dir?=build

rule/configure:
	sources_layers+=sources/tizen-distro/meta-tizen/meta-tizen-micro
