#! /usr/bin/make -f
# Author: Philippe Coval <rzr@users.sf.net>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=stm32
bsp_variant?=mp
bsp?=${bsp_family}-${bsp_variant}

board_vendor?=${bsp_family}
board_family?=${board_vendor}${bsp_variant}
board_variant?=1
board_alias?=${board_vendor}${board_variant}

MACHINE?=${board_family}${board_variant}
