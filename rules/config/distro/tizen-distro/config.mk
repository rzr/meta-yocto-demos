#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=generic
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}
board_vendor?=${bsp}
board_family?=${board_vendor}x86
board_variant?=
board_alias?=${board_family}${board_variant}
MACHINE?=${board_family}${board_variant}
machine?=${MACHINE}
machines?=${machine} ${machine}-64

os?=tizen
os_profile?=ivi
distro?=${os}-distro
distro_branch?=${os}
init_name?=${os}-${os_profile}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

extra?=
init_name?=${os}
image_type?=core
image?=${init_name}-${image_type}-image
base_image?=${init_name}-${image_type}-image
image?=${base_image}
images?=${image} \
 ${init_name}-Modello-image \
 ${init_name}-ico-image \
 #eol

sources_name?=sources-${MACHINE}
sources_layers_conf?=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))

sources_layers_conf+= ${sources_name}/tizen-distro/meta-tizen/meta-tizen-ivi/conf/layer.conf
branch?=master

bsp_machines_dir?=${distro_machines_dir}
