#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SELF?=${CURDIR}/rules/60-tasks.mk


configure: rule/overide/configure

rebuild: rule/overide/rebuild
	date

all: rule/overide/all
	date

clean: rule/overide/clean

cleanall: rule/overide/cleanall

help: rule/overide/help

setup: rule/overide/setup

run: rule/overide/run
