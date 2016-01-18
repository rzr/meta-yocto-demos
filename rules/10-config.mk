#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=raspberrypi
bsp?=${root_bsp}
MACHINE?=${bsp}
machine?=${MACHINE}2
machines?=${machine}
os?=tizen
os_profile?=common
distro?=${os}-distro
extra?=
init_name?=${os}-${os_profile}
base_image?=core-image-minimal
image?=oic-demo-image
images?=${base_image} \
 tizen-base-image \
 ${image} \
 ${os}-${os_profile}-${base_image} \
 tizen-common-core-image-crosswalk \
 tizen-common-core-image-crosswalk-dev \
 rpi-hwup-image

sources_layers_conf?=$(sort $(wildcard sources/meta-*/conf/layer.conf))

sources_layers_conf+= \
 # sources/tizen-distro/meta-tizen/meta-tizen-micro/conf/layer.conf \
 # meta-tizen-raspberrypi/conf/layer.conf

#TODO: sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-raspberry-pi/conf/layer.conf
