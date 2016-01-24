#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=amlogic
board_family?=odroid
board_variant?=c1
MACHINE?=${board_family}${board_variant}

include rules/config/bsp/${bsp}/config.mk
