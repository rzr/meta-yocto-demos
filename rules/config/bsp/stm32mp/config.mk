#! /usr/bin/make -f
# Author: Philippe Coval <rzr@users.sf.net>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

bsp_family?=stm32
bsp_variant?=mp
bsp?=${bsp_family}${bsp_variant}

board_vendor?=${bsp}
board_family?=${board_vendor}
board_variant?=1
board_alias?=${board_vendor}${board_variant}

MACHINE?=${board_family}${board_variant}

# Only valid for distros not BSP's config
bsp_machines_dir?=${distro_machines_dir}
