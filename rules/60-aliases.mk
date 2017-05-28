#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:
SELF?=${CURDIR}/rules/60-tasks.mk


configure: rule/override/configure

rebuild: rule/override/rebuild
	date

all: rule/override/all
	date

clean: rule/override/clean

cleanall: rule/override/cleanall

help: rule/override/help

setup: rule/override/setup
