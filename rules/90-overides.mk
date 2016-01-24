#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:


rule/overide/patch/tizen-distro/ldconfig: sources/tizen-distro/meta-tizen/
	-grep -r '^[\ ]*ldconfig[\ ]*$$' $< | cut -d: -f1 | sort | uniq | while read t ; do \
 sed -e 's/^[ ]*ldconfig[ ]*$$/\[ \"\" != "\$$D\" \] || ldconfig # TODO/g' -i $$t  && echo "ldconfig: $$t" ; \
 done  | grep ldconfig

rule/overide/patch/tizen-distro: sources/tizen-distro/
	-find $< -type f -exec sed -e 's/\[ \"x$$D\" == \"x\" \] && ldconfig/\[ \"\" != \"$$D\" \] || ldconfig/g' -i "{}" \;

#	-cd $< && git diff


rule/overide/patch/tizen-distro/todo: sources/tizen-distro/
	install -d sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-tizen-micro-raspberrypi/recipes-image/
	-mv -fv \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/recipes-image/raspberrypi2/rpi-hwup-image-tizen-micro.bb \
	 sources/tizen-distro/meta-tizen/meta-tizen-micro/meta-tizen-micro-raspberrypi/recipes-image/tizen-micro-rpi-hwup-image.bb 
	-rm -rfv sources/tizen-distro/meta-tizen/meta-tizen-common-base/recipes-image/images/

rule/overide/patch/meta-oic/master:  sources/meta-oic/
	-mv -v $</recipes-kernel/linux/linux-yocto_3.19.bbappend \
	$</recipes-kernel/linux/linux-yocto_3.17.bbappend

rule/overide/patch: rule/sources rule/overide/patch/tizen-distro rule/overide/patch/meta-oic/master rule/overide/patch/meta-${bsp}/master

rule/overide/sources: rule/sources rule/done/patch

rule/overide/configure-conf: rule/configure-conf rule/overide/sources
	ls -l ${conf_file}
#	ls -l sources/meta-*${bsp}/conf/machine/${MACHINE}.conf

rule/overide/packages: \
 rule/bitbake/build/weston \
 rule/bitbake/build/cogl-1.0 \
 rule/bitbake/build/cairo \
 rule/bitbake/build/harfbuzz \
 rule/bitbake/build/wayland \
 rule/bitbake/build/clutter-1.0 \
 rule/bitbake/build/efl \
 rule/bitbake/build/gstreamer \
 rule/bitbake/build/iotivity \
 rule/bitbake/build/iotivity-simple-client \
 rule/bitbake/build/iotivity-example \
 rule/bitbake/build/iotivity-sensorboard
	@echo "success: $@" 

rule/local/clean: rule/bitbake/cleanall/tizen-platform-wrapper \
 rule/bitbake/cleanall/tizen-platform-config

#rule/overide/image: rule/overide/packages rule/image

