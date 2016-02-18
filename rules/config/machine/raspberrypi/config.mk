#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=raspberrypi
board_family?=${bsp}
board_variant?=
MACHINE?=${board_family}${board_variant}

include rules/config/bsp/${bsp}/config.mk
