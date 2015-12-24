#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:


bsp_vendor?=amlogic
bsp_family?=${bsp_vendor}
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_vendor?=
board_family?=odroid
board_variant?=c1
board_alias?=${board_family}${board_variant}

MACHINE?=${board_family}${board_variant}

sources_name?=sources-${MACHINE}
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
