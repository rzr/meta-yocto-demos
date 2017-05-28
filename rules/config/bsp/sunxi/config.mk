#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
root_bsp=sunxi
bsp?=${root_bsp}
MACHINE?=olinuxino-a20
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
 ${image} \
 ${os}-${os_profile}-${base_image} \
 tizen-common-core-image-crosswalk \
 tizen-common-core-image-crosswalk-dev

sources_layers_conf+=$(sort $(wildcard sources/meta-*/conf/layer.conf))
#sources_layers_conf+=meta-tizen-${bsp}/conf/layer.conf

rule/override/patch/meta-sunxi/%: rule/done/patch-sunxi-mali
	@echo "should happend once"

rule/override/patch-sunxi-mali: sources/meta-sunxi/conf/machine/include/sunxi-mali.inc
       echo 'TUNE_FEATURES     = "arm armv7ve vfp  neon"' >> $<
       echo 'TARGET_FPU        = "softfp"' >> $<
