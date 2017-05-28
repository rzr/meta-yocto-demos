#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:


todo/rule/override/patch/tizen-distro/ldconfig: ${sources_name}/tizen-distro/meta-tizen/
	-grep -r '^[\ ]*ldconfig[\ ]*$$' $< | cut -d: -f1 | sort | uniq | while read t ; do \
 sed -e 's/^[ ]*ldconfig[ ]*$$/\[ \"\" != "\$$D\" \] || ldconfig # TODO/g' -i $$t  && echo "ldconfig: $$t" ; \
 done  | grep ldconfig

todo/rule/override/patch/tizen-distro: ${sources_name}/tizen-distro/
	-find $< -type f -exec sed -e 's/\[ \"x$$D\" == \"x\" \] && ldconfig/\[ \"\" != \"$$D\" \] || ldconfig/g' -i "{}" \;

#	-cd $< && git diff

rule/override/patch/tizen-distro/todo: ${sources_name}/tizen-distro/
	install -d ${sources_name}/tizen-distro/meta-tizen/meta-tizen-micro/meta-tizen-micro-raspberrypi/recipes-image/
	-mv -fv \
	 ${sources_name}/tizen-distro/meta-tizen/meta-tizen-micro/recipes-image/raspberrypi2/rpi-hwup-image-tizen-micro.bb \
	 ${sources_name}/tizen-distro/meta-tizen/meta-tizen-micro/meta-tizen-micro-raspberrypi/recipes-image/tizen-micro-rpi-hwup-image.bb 
	-rm -rfv ${sources_name}/tizen-distro/meta-tizen/meta-tizen-common-base/recipes-image/images/

rule/override/patch/meta-oic/master:  ${sources_name}/meta-oic/
	-mv -v $</recipes-kernel/linux/linux-yocto_3.19.bbappend \
	$</recipes-kernel/linux/linux-yocto_3.17.bbappend

rule/override/patch: rule/sources rule/override/patch/tizen-distro rule/override/patch/meta-oic/master rule/override/patch/meta-${bsp}/master

rule/override/sources: rule/sources rule/done/patch

rule/override/configure-conf: rule/configure-conf rule/override/configure-bsp rule/override/sources
	ls -l ${conf_file}
#	ls -l ${sources_name}/meta-*${bsp}/conf/machine/${MACHINE}.conf


rule/override/patch/tizen-distro: ${sources_name}
	-find $< -type -f -exec sed -e 's/review.tizen.org/git.tizen.org/g' -i "{}" \;

rule/override/packages: \
 rule/bitbake/build/cairo \
 rule/bitbake/build/clutter-1.0 \
 rule/bitbake/build/cogl-1.0 \
 rule/bitbake/build/efl \
 rule/bitbake/build/gstreamer \
 rule/bitbake/build/harfbuzz \
 rule/bitbake/build/iotivity \
 rule/bitbake/build/iotivity-example \
 rule/bitbake/build/iotivity-sensorboard
 rule/bitbake/build/iotivity-simple-client \
 rule/bitbake/build/poppler \
 rule/bitbake/build/syslinux \
 rule/bitbake/build/wayland \
 rule/bitbake/build/weston \
	@echo "success: $@" 

rule/local/clean: \
 rule/bitbake/cleanall/config-image \
 rule/bitbake/cleanall/tizen-platform-config \
 rule/bitbake/cleanall/tizen-platform-wrapper \
 rule/bitbake/cleanall/weston-init \
 #eol

#rule/override/image: rule/override/packages rule/image

