#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

configure: rule/override/configure
	@echo "log: $@: $^"

rebuild: rule/override/rebuild
	@echo "log: $@: $^"

all: rule/override/all
	@echo "log: $@: $^"

clean: rule/override/clean
	@echo "log: $@: $^"

cleanall: rule/override/cleanall
	@echo "log: $@: $^"

help: rule/override/help
	@echo "log: $@: $^"

longhelp: rule/override/longhelp
	@echo "log: $@: $^"

print: rule/override/print
	@echo "log: $@: $^"

setup: rule/override/setup
	@echo "log: $@: $^"

run: rule/override/run
	@echo "log: $@: $^"

machines: ${machines_list}
	df -h .
