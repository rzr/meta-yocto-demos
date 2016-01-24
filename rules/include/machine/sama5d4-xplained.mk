SHELL=/bin/bash
V=1
root_bsp=atmel
bsp?=${root_bsp}
board_family?=sama5d4
board_variant?=xplained
MACHINE?=${board_family}-${board_variant}

machine?=${MACHINE}

include rules/include/bsp/${bsp}/config.mk
