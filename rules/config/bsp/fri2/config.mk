#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:


bsp_vendor?=intel
bsp_family?=fri
bsp_variant?=2
bsp?=${bsp_family}${bsp_variant}

board_vendor?=${bsp_vendor}
board_family?=${bsp}
board_variant?=-noemgd
board_alias?=${board_family}${board_variant}

MACHINE?=${board_family}${board_variant}


sources_name?=sources-${MACHINE}
sources_layers_conf?=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_layers_conf+=${sources_name}/meta-${bsp_vendor}/meta-${bsp}/conf/layer.conf
bsp_machines_dir?=${sources_name}/meta-${bsp_vendor}/meta-${bsp}/conf/machine
