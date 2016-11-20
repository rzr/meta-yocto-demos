#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=raspberrypi
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_vendor?=raspberrypi
board_family?=${bsp}
board_variant?=3
board_alias?=${board_family}${board_variant}

MACHINE?=${board_family}${board_variant}

machine?=${MACHINE}
machines?=${machine} ${bsp} ${bsp}2 ${bsp}0 ${bsp}3

base_image?=rpi-hwup-image
sources_name?=sources-${MACHINE}
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_dir?=${CURDIR}/${sources_name}

rule/override/patch/meta-raspberrypi/master: ${sources_dir} ${sources_dir}/meta-raspberrypi
	-sed -e 's|STAGING_KERNEL_BUILDDIR|STAGING_KERNEL_DIR|g' -i  \
	 ${<}/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass
	-sed -e 's|get_kernelversion_file|get_kernelversion|g' -i  \
	${<}/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass
	ls $<

override_tasks+=rule/override/patch/meta-raspberrypi/master
