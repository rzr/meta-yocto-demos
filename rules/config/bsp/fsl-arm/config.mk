#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=fsl
bsp_variant?=-arm
bsp?=${bsp_family}${bsp_variant}

board_vendor?=imx6q
board_family?=${board_vendor}sabre
board_variant?=sd
board_alias?=${board_vendor}${board_variant}

MACHINE?=${board_family}${board_variant}
