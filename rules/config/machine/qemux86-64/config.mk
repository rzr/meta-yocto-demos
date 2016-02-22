#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=generic
board_family?=qemux86
board_variant?=64
MACHINE?=${board_family}-${board_variant}
