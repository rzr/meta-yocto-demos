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
base_image?=genivi-demo-platform
image?=${base_image}
images?=${base_image} \
 #eol

sources_layers_conf+=$(sort $(wildcard sources/meta-*/conf/layer.conf))
sources_layers_conf+=sources/meta-openembedded/meta-oe/conf/layer.conf
sources_layers_conf+=sources/meta-openembedded/meta-ruby/conf/layer.conf
sources_layers_conf+=sources/meta-ivi/meta-ivi/conf/layer.conf
sources_layers_conf+=sources/meta-ivi/meta-ivi-bsp/conf/layer.conf
#sources_layers_conf+=sources/meta-ivi/meta-ivi-demo/conf/layer.conf

rule/overide/configure-conf: rule/configure-conf
	sed -e 's|^DISTRO.*=.*|DISTRO ?= "poky-ivi-systemd"|g' -i ${conf_file}
