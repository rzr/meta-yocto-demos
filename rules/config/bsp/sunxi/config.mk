#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=sunxi
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_vendor?=olimex
board_family?=olinuxino
board_variant?=-a20
board_alias?=${board_vendor}${board_variant}

MACHINE?=${board_family}${board_variant}

sources_name?=sources-${MACHINE}
sources_layers_conf+=${sources_name}/meta-${bsp}/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-openembedded/meta-oe/conf/layer.conf

