#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

rule/overide/rule/configure-conf: rule/configure-conf
	install -d sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-raspberrypi/recipes-image/
	-mv -fv \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/recipes-image/raspberrypi2/rpi-hwup-image-tizen-micro.bb \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-raspberrypi/recipes-image/tizen-micro-rpi-hwup-image.bb 
	ls -l ${conf_file}

rule/overide/rule/all: rule/all \
  rule/bitbake/task/iotivity \
  rule/bitbake/task/iotivity-simple-client \
  rule/bitbake/task/iotivity-example \
  rule/bitbake/task/iotivity-sensorboard
	@echo "success: $@" 
