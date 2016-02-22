#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=raspberrypi
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_vendor?=raspberrypi
board_family?=${bsp}
board_variant?=
board_alias?=${board_family}${board_variant}

MACHINE?=${board_family}${board_variant}

machine?=${MACHINE}
machines?=${machine} ${bsp} ${bsp}2 ${bsp}0

base_image?=rpi-hwup-image
