#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=artik
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_vendor?=samsung
board_family?=${bsp}
board_variant?=10
board_alias?=${board_family}${board_variant}

MACHINE?=${board_family}${board_variant}

