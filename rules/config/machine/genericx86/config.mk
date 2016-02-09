#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=generic
board_family?=${bsp}x86
board_variant?=
MACHINE?=${board_family}

include rules/config/bsp/${bsp}/config.mk
