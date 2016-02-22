#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1

default: GNUmakefile
	${MAKE} rule/overide/default

%: rule/overide/help
