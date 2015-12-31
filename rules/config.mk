#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=intel
bsp?=fri2
MACHINE?=${bsp}-noemgd

os?=tizen
os_profile?=common
distro?=${os}-distro
extra?=
init_name?=${os}-${os_profile}
base_image?=core-image-minimal
image?=${os}-${base_image}
images?=${image} \
 ${os}-${os_profile}-core-image-minimal \
 ${os}-${os_profile}-core-image-crosswalk

sources_layers_conf?=$(sort $(wildcard sources/meta-*/conf/layer.conf))
sources_layers_dirs?=$(dir ${sources_layers_conf})
sources_layers?=$(shell dirname $(sources_layers_dirs))

sources_layers+=sources/meta-${root_bsp}/meta-${bsp} 
