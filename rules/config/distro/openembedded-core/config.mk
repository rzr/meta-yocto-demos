#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
bsp_family?=qemu
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}
board_family?=qemu
board_variant?=x86
MACHINE?=${board_family}${board_variant}
machine?=${MACHINE}
machines?=${machine} ${machine}-64

os?=oe
os_profile?=
distro?=openembedded-core
extra?=
init_name?=${os}
base_image?=core-image-minimal
image?=${base_image}
images?=${image} \
 ${base_image} \
 core-image-minimal \
 core-image-minimal-dev \
 core-image-weston

sources_name?=sources-${MACHINE}
sources_layers_conf?=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-*/meta-*/conf/layer.conf))
branch?=master

rule/override/configure-conf: rule/configure-conf
	ls -l -- "${conf_file}"
	echo "DISTRO_FEATURES += ' opengl'" | tee -a -- "${conf_file}"
	echo "DISTRO_FEATURES += ' x11'" | tee -a -- "${conf_file}"
