#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

configure: rule/overide/configure

rebuild: rule/overide/rebuild
	date

all: rule/overide/all
	date

clean: rule/overide/clean

cleanall: rule/overide/cleanall

help: rule/overide/help

longhelp: rule/overide/longhelp

print: rule/overide/print

setup: rule/overide/setup

run: rule/overide/run

machines: ${machines_list}
	df -h .


