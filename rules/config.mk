#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

root_bsp=sunxi
bsp?=${root_bsp}
MACHINE?=olinuxino-a20

os?=tizen
os_profile?=common
distro?=${os}-distro
extra?=
init_name?=${os}-${os_profile}
base_image?=core-image-minimal
image?=${base_image}

sources_layers?=$(sort $(wildcard sources/meta-*))

