#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=sunxi
board_family?=olinuxino
board_variant?=a20
MACHINE?=${board_family}-${board_variant}

include rules/config/bsp/${bsp}/config.mk
