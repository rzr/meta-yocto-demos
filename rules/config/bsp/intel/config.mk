#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=intel
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_family?=${bsp}-corei7
board_variant?=-64
MACHINE?=${board_family}${board_variant}

machine?=${MACHINE}
machines+=${machine}
