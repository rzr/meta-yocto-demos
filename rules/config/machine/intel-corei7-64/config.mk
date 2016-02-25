#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=intel
board_family?=${bsp}-corei7
board_variant?=64
MACHINE?=${board_family}-${board_variant}

include rules/config/bsp/${bsp}/config.mk
