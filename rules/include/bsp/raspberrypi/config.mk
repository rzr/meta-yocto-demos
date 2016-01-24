#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=raspberrypi
bsp?=${root_bsp}
MACHINE?=${bsp}2
machine?=${MACHINE}
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

sources_layers_conf+=$(sort $(wildcard sources/meta-*/conf/layer.conf))
sources_layers_conf+=meta-tizen-raspberrypi/conf/layer.conf


rule/overide/patch/meta-raspberrypi/master: sources/meta-raspberrypi
	-sed -e 's|STAGING_KERNEL_BUILDDIR|STAGING_KERNEL_DIR|g' -i  \
	 sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass
	-sed -e 's|get_kernelversion_file|get_kernelversion|g' -i  \
	sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass

rule/overide/patch/meta-raspberrypi/dizzy: sources/meta-raspberrypi
	mkdir -p recipes-graphics/cairo
	echo 'CFLAGS_append_raspberrypi="-I\${STAGING_INCDIR}/interface/vcos/pthreads/ -I\${STAGING_INCDIR}/interface/vmcs_host/linux/"' \
	> recipes-graphics/cairo/cairo_1.12.16.bbappend
