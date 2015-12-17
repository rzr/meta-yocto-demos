#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
bsp?=raspberrypi
MACHINE?=${bsp}2
machine?=${MACHINE}

os=tizen
os_profile=common
branch?=${os}-${bsp}
repo_branch?=${branch}
distro?=${os}-distro
init_name?=${os}-${os_profile}
image?=rpi-hwup-image
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

