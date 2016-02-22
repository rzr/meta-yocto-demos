#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=intel
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_vendor?=${bsp_family}
board_family?=${board_vendor}-corei7
board_variant?=-64
board_alias?=${board_vendor}${board_variant}

MACHINE?=${board_family}${board_variant}
