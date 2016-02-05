#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=intel
board_family?=fri2
board_variant?=noemgd
MACHINE?=${board_family}-${board_variant}

include rules/config/bsp/${bsp}/config.mk
