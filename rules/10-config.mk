#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=qemu
bsp?=${root_bsp}
MACHINE?=${bsp}x86

os?=oe
os_profile?=
distro?=core
extra?=
init_name?=${os}
base_image?=core-image-minimal
image?=oic-core-image
images?=${image} ${base_image} ${base_image}-dev

sources_layers_conf?=$(sort $(wildcard sources/meta-*/conf/layer.conf))

sources_layers_conf+=sources/meta-openembedded/meta-oe/conf/layer.conf \
 sources/openembedded-core/conf/layer.conf

