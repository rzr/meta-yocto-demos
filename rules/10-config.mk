#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=generic
bsp?=${root_bsp}
board_family?=${bsp}x86
#board_variant?=64
MACHINE?=${board_family}
machine?=${MACHINE}
machines?=${machine} ${machine}-64

os?=oe
os_profile?=
distro?=poky
extra?=
init_name?=${os}
base_image?=core-image-minimal
image?=${base_image}
images?=${image} ${image}-dev

sources_name?=sources-${MACHINE}
sources_layers_conf?=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))

sources_layers_conf+=
