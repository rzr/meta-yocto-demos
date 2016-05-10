#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
bsp_family?=generic
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}
board_family?=qemu
board_variant?=x86
MACHINE?=${board_family}${board_variant}
machine?=${MACHINE}
machines?=${machine} ${machine}-64

os?=oe
os_profile?=
distro?=poky
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

sources_layers_conf+=
branch?=master

agl_repo_url?=https://download.automotivelinux.org/AGL/snapshots/master/latest/intel-corei7-64/intel-corei7-64_repo_default.xml
agl_conf_url?=https://download.automotivelinux.org/AGL/snapshots/master/latest/intel-corei7-64/local.conf

rule/agl/update: rules/config/bsp/intel/default.xml
	wget -O$< ${agl_repo_url}
	wget -O rules/config/bsp/intel/local.conf ${agl_conf_url}

