#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=amlogic
bsp?=${root_bsp}
MACHINE?=odroidc1

os?=oe
os_profile?=
distro?=poky
extra?=
init_name?=${os}
base_image?=core-image-minimal
image?=${base_image}
images?=${image} ${image}-dev

sources_layers_conf?=$(sort $(wildcard sources/meta-*/conf/layer.conf))

sources_layers_conf+=

