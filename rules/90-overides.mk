#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

rule/machine/${MACHINE}/configure:
	install -d sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-raspberrypi/recipes-image/
	-mv -fv \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/recipes-image/raspberrypi2/rpi-hwup-image-tizen-micro.bb \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-raspberrypi/recipes-image/tizen-micro-rpi-hwup-image.bb 
	install -d ../tmp/${CURDIR}
	-mv -v sources/meta-50-oic/recipes-kernel ../tmp/${CURDIR}


rule/overide/rule/configure-conf: rule/configure-conf rule/machine/${MACHINE}/configure
	ls -l ${conf_file}
	ls -l sources/meta-*${bsp}/conf/machine/${MACHINE}.conf


rule/wip:
	mv sources/tizen-distro/meta-tizen sources/tizen-distro/meta-tizen.orig
	ln -fs \
  /home/philippe/var/cache/url/git/ssh/review.tizen.org/scm/bb/meta-tizen/src/meta-tizen \
  sources/tizen-distro/meta-tizen


rule/overide/rule/all: rule/all \
  rule/bitbake/task/iotivity \
  rule/bitbake/task/iotivity-simple-client \
  rule/bitbake/task/iotivity-example \
  rule/bitbake/task/iotivity-sensorboard
	@echo "success: $@" 
