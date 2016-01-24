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

rule/overide/patch/meta-oic:  sources/meta-oic/
	-mv -v $</recipes-kernel/linux/linux-yocto_3.19.bbappend \
	$</recipes-kernel/linux/linux-yocto_3.17.bbappend

rule/overide/patch/%:
	$(info no patch for $@)

rule/overide/patch/meta-raspberrypi/master: sources/meta-raspberrypi
	-sed -e 's|STAGING_KERNEL_BUILDDIR|STAGING_KERNEL_DIR|g' -i  \
	 sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass
	-sed -e 's|get_kernelversion_file|get_kernelversion|g' -i  \
	sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass

rule/overide/patch/meta-sunxi/master: sources/meta-sunxi/conf/machine/include/sunxi-mali.inc
	echo 'TUNE_FEATURES     = "arm armv7ve vfp  neon"' >> $<
	echo 'TARGET_FPU        = "softfp"' >> $<

rule/overide/patch/meta-raspberrypi/dizzy: sources/meta-raspberrypi
	mkdir -p recipes-graphics/cairo
	echo 'CFLAGS_append_raspberrypi="-I\${STAGING_INCDIR}/interface/vcos/pthreads/ -I\${STAGING_INCDIR}/interface/vmcs_host/linux/"' \
	> recipes-graphics/cairo/cairo_1.12.16.bbappend

rule/overide/patch: rule/sources rule/overide/patch/tizen-distro rule/overide/patch/meta-oic rule/overide/patch/meta-${bsp}/master

rule/overide/sources: rule/sources rule/done/patch

rule/overide/configure-conf: rule/configure-conf rule/overide/sources
	ls -l ${conf_file}
#	ls -l sources/meta-*${bsp}/conf/machine/${MACHINE}.conf

rule/overide/packages: \
 rule/bitbake/task/weston \
 rule/bitbake/task/cogl-1.0 \
 rule/bitbake/task/cairo \
 rule/bitbake/task/harfbuzz \
 rule/bitbake/task/wayland \
 rule/bitbake/task/clutter-1.0 \
 rule/bitbake/task/efl \
 rule/bitbake/task/gstreamer \
 rule/bitbake/task/iotivity \
 rule/bitbake/task/iotivity-simple-client \
 rule/bitbake/task/iotivity-example \
 rule/bitbake/task/iotivity-sensorboard
	@echo "success: $@" 

rule/local/clean: rule/bitbake/cleanall/tizen-platform-wrapper \
 rule/bitbake/cleanall/tizen-platform-config

#rule/overide/image: rule/overide/packages rule/image

