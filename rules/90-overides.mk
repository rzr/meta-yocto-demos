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

local/todo:
	cd  sources/meta-raspberrypi/ && \
	git cherry-pick 54c5451a04a2b6601ca729038780d4e4eb69437e

	cd  sources/meta-raspberrypi/ && \
	git cherry-pick	1949a0d5ba134036a590a41fd414f3bdd7ecee9e

rule/overide/patch/%:
	$(info no patch for $@)

rule/overide/patch/meta-raspberrypi/master: sources/meta-raspberrypi
	-sed -e 's|STAGING_KERNEL_BUILDDIR|STAGING_KERNEL_DIR|g' -i  \
	 sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass
	-sed -e 's|get_kernelversion_file|get_kernelversion|g' -i  \
	sources/meta-raspberrypi/classes/linux-raspberrypi-base.bbclass

rule/overide/patch/meta-raspberrypi/dizzy: sources/meta-raspberrypi
	mkdir -p recipes-graphics/cairo
	echo 'CFLAGS_append_raspberrypi="-I\${STAGING_INCDIR}/interface/vcos/pthreads/ -I\${STAGING_INCDIR}/interface/vmcs_host/linux/"' \
	> recipes-graphics/cairo/cairo_1.12.16.bbappend

rule/overide/patch: rule/sources rule/overide/patch/tizen-distro rule/overide/patch/meta-oic rule/overide/patch/meta-${bsp}/master

rule/overide/sources: rule/sources rule/done/patch

rule/overide/configure-conf: rule/configure-conf rule/overide/sources
	ls -l ${conf_file}
#	ls -l sources/meta-*${bsp}/conf/machine/${MACHINE}.conf


rule/wip/patch: rule/overide/patch/meta-raspberrypi
	mv sources/tizen-distro/meta-tizen sources/tizen-distro/meta-tizen.orig
	ln -fs \
 /home/philippe/var/cache/url/git/ssh/review.tizen.org/scm/bb/meta-tizen/src/meta-tizen \
 sources/tizen-distro/meta-tizen

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


rule/wip/cleanall: \
 rule/bitbake/cleanall/bluetooth-tools \
 rule/bitbake/cleanall/config-image \
 rule/bitbake/cleanall/desktop-skin \
 rule/bitbake/cleanall/gumd \
 rule/bitbake/cleanall/initramfs-live-boot \
 rule/bitbake/cleanall/initramfs-live-install \
 rule/bitbake/cleanall/initramfs-live-install-efi \
 rule/bitbake/cleanall/pam \
 rule/bitbake/cleanall/rpcbind \
 rule/bitbake/cleanall/rpm \
 rule/bitbake/cleanall/samba \
 rule/bitbake/cleanall/systemd-serialgetty \
 rule/bitbake/cleanall/tizen-platform-config \
 rule/bitbake/cleanall/tizen-platform-wrapper \
 rule/bitbake/cleanall/tlm \
 rule/bitbake/cleanall/udev-extraconf \
 rule/bitbake/cleanall/weston \
 rule/bitbake/cleanall/weston-init \
 rule/bitbake/cleanall/wpa-supplicant \
 #eol

rule/wip/rebuild: rule/wip/cleanall \
 rule/bitbake/tlm

rule/wip: \
 rule/bitbake/cleanall/userland rule/bitbake/task/userland \
 rule/bitbake/cleanall/cairo rule/bitbake/task/cairo \
 rule/bitbake/cleanall/harfbuzz rule/bitbake/task/harfbuzz \
 rule/bitbake/cleanall/config-image rule/bitbake/task/config-image

rule/wip/help:
	make rule/bitbake/args ARGS="-e" | grep BBPATH

#rule/overide/image: rule/overide/packages rule/image
