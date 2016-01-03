SUMMARY = "A headless image with a few tools for IoT"
DESCRIPTION = "A headless image based on Tizen common"

inherit core-image distro_features_check

#CORE_IMAGE_EXTRA_INSTALL += "nodejs"

CORE_IMAGE_EXTRA_INSTALL += "wpa-supplicant wpa-supplicant-cli"
CORE_IMAGE_EXTRA_INSTALL += "openssh"
CORE_IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty procps"

CORE_IMAGE_EXTRA_INSTALL += "nginx"
CORE_IMAGE_EXTRA_INSTALL += "v4l2grab"

require recipes-image/images/target-image-common.inc
