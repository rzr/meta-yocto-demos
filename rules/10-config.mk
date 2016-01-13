#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

root_bsp=atmel
bsp?=${root_bsp}

board_vendor?=at91
board_family?=sama5d4
board_variant?=xplained
board_alias?=${board_family}x-ek
MACHINE?=${board_family}-${board_variant}

os?=oe
os_profile?=
distro?=poky
extra?=
init_name?=${os}
base_image?=core-image-minimal
image?=${bsp}-${board_variant}-lcd-demo-image
images?=${image} \
 core-image-weston

sources_layers_conf?=$(sort $(wildcard sources/meta-*/conf/layer.conf))

sources_layers_conf+= \
 sources/meta-openembedded/meta-python/conf/layer.conf \
 sources/meta-openembedded/meta-networking/conf/layer.conf \
 sources/meta-openembedded/meta-oe/conf/layer.conf

