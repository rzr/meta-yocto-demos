#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=fsl-arm
bsp?=${root_bsp}
MACHINE?=imx6qsabresd
machine?=${MACHINE}
MACHINE?=${bsp}2
machine?=${MACHINE}
machines?=${machine}
os?=tizen
os_profile?=common
distro?=${os}-distro
extra?=
init_name?=${os}-${os_profile}
base_image?=core-image-minimal
image?=${base_image}
images?=${base_image}

sources_layers_conf+=$(sort $(wildcard sources/meta-*/conf/layer.conf))

rule/overide/configure-bsp: ${conf_file}
	ls $<
	echo "TODO: display EULA"
	echo "ACCEPT_FSL_EULA = \"1\"" >> ${conf_file}
#	echo "DISTRO_FEATURES_remove = \" x11 wayland \"" >> ${conf_file}
