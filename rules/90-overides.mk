#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

-include rules/config/bsp/${bsp}/config.mk

rule/override/all: ${override_tasks} rule/all
	$(warning # log: skip building ${@F}: ${ARG})

#rule/override/image:
#	$(warning # log: skip building ${@F}: ${ARG})

#rule/override/list-images:
#	$(info # log: skip $@)

#rule/override/configure-conf: rule/configure-conf
#	ls -l ${conf_file}

#rule/override/pre: rule/override/bsps rule/pre
