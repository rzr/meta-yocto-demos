bsp?=raspberrypi
MACHINE?=${bsp}
repo_branch?=machine/${MACHINE}
image?=rpi-hwup-image

define BBLAYERS
BBLAYERS += " \"\
  ${CURDIR}/sources/meta-${bsp} \
  \"\
"
endef
export BBLAYERS
