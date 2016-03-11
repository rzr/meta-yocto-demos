#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

MACHINE?=qemux86
-include rules/config/machine/${MACHINE}/config.mk

bsp?=generic
include rules/config/bsp/${bsp}/config.mk

distro?=poky
include rules/config/distro/${distro}/config.mk

