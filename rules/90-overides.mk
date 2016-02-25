#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

-include rules/config/bsp/${bsp}/config.mk

#rule/overide/all:
#	$(warning # log: skip building ${@F}: ${ARG})

#rule/overide/image:
#	$(warning # log: skip building ${@F}: ${ARG})

#rule/overide/list-images:
#	$(info # log: skip $@)

#rule/overide/configure-conf: rule/configure-conf
#	ls -l ${conf_file}

#rule/overide/pre: rule/overide/bsps rule/pre
