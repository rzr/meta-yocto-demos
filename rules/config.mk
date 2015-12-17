#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

MACHINE?=raspberrypi2
image?=tizen-oic-image
bsp=raspberrypi

repo_branch?=sandbox/pcoval/${bsp}
repo_branch?=machine/${MACHINE}
branch?=tizen
#image?=rpi-hwup-image
image?=tizen-base-image
distro?=tizen-distro

project_dir?=${CURDIR}
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf

branch?=tizen
repo_branch?=sandbox/pcoval/oic
distro?=${branch}-distro
init_name?=${branch}-common
MACHINE?=qemux86
machine?=${MACHINE}

#image?=rpi-hwup-image
image?=tizen-base-image
distro?=tizen-distro
image?=${init_name}-core-image-minimal
