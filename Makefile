#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
project_dir?=${CURDIR}
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf

MACHINE?=raspberrypi2

include rules/config.mk
-include rules/machine/${MACHINE}/conf-bsp.mk
include rules/tasks.mk

