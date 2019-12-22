#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

ifneq ("${MACHINE}","")
include rules/config/machine/${MACHINE}/config.mk
endif

bsp?=generic
include rules/config/bsp/${bsp}/config.mk

distro?=openembedded-core
include rules/config/distro/${distro}/config.mk

