#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

bsp?=amlogic
MACHINE?=odroidc1

os?=poky
os_profile?=master
distro?=${os}
init_name?=oe
base_image?=core-image-minimal
image?=${base_image}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
cache_dir?=${CURDIR}/
build_dir?=${cache_dir}build


conf_file?=${build_dir}/conf/local.conf

rule/configure/conf: ${conf_file}
	ls $<
#	echo "DISTRO_FEATURES_remove = \" x11 wayland \"" >> $<
