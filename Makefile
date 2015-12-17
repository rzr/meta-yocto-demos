#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
#MACHINE?=genericx86-64
MACHINE?=raspberrypi2
image?=tizen-oic-image

project_dir?=${CURDIR}
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf

include rules/global.mk
-include rules/machine/${MACHINE}/conf-bsp.mk
include rules/config.mk
#include rules/machine.mk
include rules/layers.mk
include rules/tasks.mk

