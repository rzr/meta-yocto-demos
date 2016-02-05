#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=atmel
board_family?=sama5d4
board_variant?=xplained
MACHINE?=${board_family}-${board_variant}

include rules/config/bsp/${bsp}/config.mk
