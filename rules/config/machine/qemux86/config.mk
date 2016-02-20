#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=generic
board_family?=qemu
board_variant?=x86
MACHINE?=${board_family}${board_variant}

include rules/config/bsp/${bsp}/config.mk
