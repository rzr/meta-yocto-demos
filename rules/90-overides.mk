#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

rule/patch/tizen-distro: sources/tizen-distro/
	install -d sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-tizen-micro-raspberrypi/recipes-image/
	-mv -fv \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/recipes-image/raspberrypi2/rpi-hwup-image-tizen-micro.bb \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-tizen-micro-raspberrypi/recipes-image/tizen-micro-rpi-hwup-image.bb 

rule/patch/meta-oic:  sources/meta-oic/
	-mv -v $</recipes-kernel/linux/linux-yocto_3.19.bbappend \
	$</recipes-kernel/linux/linux-yocto_3.17.bbappend

rule/patch/meta-raspberrypi:  sources/meta-raspberrypi
	cd  sources/meta-raspberrypi/ && \
	git cherry-pick 54c5451a04a2b6601ca729038780d4e4eb69437e

	cd  sources/meta-raspberrypi/ && \
	git cherry-pick	1949a0d5ba134036a590a41fd414f3bdd7ecee9e

	-sed -e 's|STAGING_KERNEL_BUILDDIR|STAGING_KERNEL_DIR|g' -i  \
	 sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass
	-sed -e 's|get_kernelversion_file|get_kernelversion|g' -i  \
	sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass

rule/overide/rule/configure-conf: rule/configure-conf rule/patch/tizen-distro rule/patch/meta-oic
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

rule/local/clean: rule/bitbake/cleanall/tizen-platform-wrapper  rule/bitbake/cleanall/tizen-platform-config
