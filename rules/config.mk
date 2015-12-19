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
image_os_profile?=micro
image?=rpi-hwup-image-tizen-micro
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

rule/configure:
sources_layers+=sources/tizen-distro/meta-tizen/meta-tizen-micro
