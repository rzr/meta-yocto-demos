#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=fsl-arm
board_family?=imx6q
board_variant?=sabresd
MACHINE?=${board_family}${board_variant}

include rules/config/bsp/${bsp}/config.mk
