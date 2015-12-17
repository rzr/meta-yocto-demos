#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
#MACHINE?=genericx86-64
MACHINE?=raspberrypi2
image?=tizen-oic-image
MACHINE?=${bsp}2
machine?=${MACHINE}
repo_branch?=sandbox/pcoval/${bsp}
repo_branch?=machine/${MACHINE}
branch?=tizen
#image?=rpi-hwup-image
image?=tizen-base-image
distro?=tizen-distro

project_dir?=${CURDIR}
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf

sources_layers?=$(wildcard sources/*)

include rules/global.mk
include rules/config.mk
include rules/tasks.mk
