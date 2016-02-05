#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=generic
bsp?=${root_bsp}
MACHINE?=${bsp}x86-64
machine?=${MACHINE}
machines?=${machine}
os?=oe
os_profile?=
distro?=poky
extra?=
init_name?=${os}${os_profile}
base_image?=core-image-minimal
image?=${base_image}
images?=${base_image} \
 #eol
sources_layers_conf+=$(sort $(wildcard sources/meta-*/conf/layer.conf))

