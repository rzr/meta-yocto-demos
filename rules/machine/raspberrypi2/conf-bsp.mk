bsp?=raspberrypi
MACHINE?=${bsp}2
repo_branch?=machine/${MACHINE}
branch?=tizen
#image?=rpi-hwup-image
image?=tizen-base-image
distro?=tizen-distro
bsp_dir?=${CURDIR}/sources/meta-${bsp}


define BBLAYERS
"\
BBLAYERS += \"\
  ${CURDIR}/sources/meta-${bsp} \
  \"\
BBLAYERS_NON_REMOVABLE += \"\
  ${CURDIR}/sources/meta-${bsp} \
  \"\
"
endef
export BBLAYERS


rule/configure/machine: tmp/bblayers-stamp tmp/local-stamp rule/build_dir  tmp/post-build-stamp


tmp/post-build-stamp:


tmp/bblayers-stamp: ${bblayers}
	echo "BBLAYERS += \" ${bsp_dir} \"" >> $<
	echo "BBLAYERS_NON_REMOVABLE += \" ${bsp_dir} \"" >> $<
	cp -v ${CURDIR}/machine/${MACHINE}/${<F} $<
	mkdir -p "$@{D}" ; touch $@

tmp/local-stamp: ${build_dir}/conf/local.conf
	cp -v ${CURDIR}/machine/${MACHINE}/${<F} $<
	mkdir -p "$@{D}" ; touch $@


tmp/post-build-stamp-debian: ${bsp_dir}/../${distro}
	cd $< && git pull . remotes/s-osg/tizen-debianhost
	@echo "TODO"
