#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=amlogic
bsp?=${root_bsp}
MACHINE?=odroidc1
machine?=${MACHINE}
machines?=${machine}

os?=tizen
os_profile?=common
distro?=${os}-distro
extra?=
init_name?=${os}-${os_profile}

base_image?=wetek-image-minimal
image?=core-image-minimal
images?=${base_image} \
 ${image} \
 #eol

unsupported_images?=\
 oic-demo-image \
 ${os}-${os_profile}-${base_image} \
 tizen-common-core-image-crosswalk \
 tizen-common-core-image-crosswalk-dev \
 #eol

sources_layers_conf+=$(sort $(wildcard sources/meta-*/conf/layer.conf))
#sources_layers_conf+=meta-tizen-${bsp}/conf/layer.conf


#conf_file?=${build_dir}/conf/local.conf

#rule/configure/conf: ${conf_file}
#	ls $<
#	echo "DISTRO_FEATURES_remove = \" x11 wayland \"" >> $<
