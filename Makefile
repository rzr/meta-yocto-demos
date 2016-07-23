#! /usr/bin/make -f

default: GNUmakefile

-include rules/01-global.mk
-include rules/50-tasks.mk

default: GNUmakefile
	${MAKE} ${@F}
