
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

rule/reset:
	make Makefile

rule/machine/%: rule/cleanall
	echo "MACHINE?=${@F}" > rules/09-local-config.mk
	echo "include rules/include/machine/${@F}.mk" >> rules/09-local-config.mk
	${MAKE} rule/bsp rule/reset

rule/bsp:
	cp config/bsp/meta-${bsp}/default.xml default.xml


local/todo:
	cd  sources/meta-raspberrypi/ && \
	git cherry-pick 54c5451a04a2b6601ca729038780d4e4eb69437e

	cd  sources/meta-raspberrypi/ && \
	git cherry-pick	1949a0d5ba134036a590a41fd414f3bdd7ecee9e

rule/wip/patch: rule/overide/patch/meta-raspberrypi
	mv sources/tizen-distro/meta-tizen sources/tizen-distro/meta-tizen.orig
	ln -fs \
 /home/philippe/var/cache/url/git/ssh/review.tizen.org/scm/bb/meta-tizen/src/meta-tizen \
 sources/tizen-distro/meta-tizen
