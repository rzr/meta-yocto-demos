#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=generic
bsp?=${root_bsp}
MACHINE?=${bsp}x86-64

machines?=${machine} \
 ${bsp}x86

os?=tizen
os_profile?=common
distro?=${os}-distro
extra?=
init_name?=${os}-${os_profile}
base_image?=core-image-minimal
image?=${base_image}

images?=${image} ${image}-dev \
 ${os}-${os_profile}-${base_image} \
 ${os}-${os_profile}-${base_image}-dev \
 tizen-common-core-image-crosswalk \
 tizen-common-core-image-crosswalk-dev


sources_layers_conf+=
