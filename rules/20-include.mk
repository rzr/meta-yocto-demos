#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

MACHINE?=qemux86
distro?=poky

include rules/config/machine/${MACHINE}/config.mk
include rules/config/distro/${distro}/config.mk

