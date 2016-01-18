SUMMARY = "A very basic Headless image"

IMAGE_FEATURES += "package-management ssh-server-dropbear"

LICENSE = "MIT"

inherit core-image distro_features_check

REQUIRED_DISTRO_FEATURES = "pam"

DISTRO_FEATURES_remove = "x11"

CORE_IMAGE_BASE_INSTALL += ""

DESCRIPTION = "A basic image for Tizen Headless usage"

DEPENDS += " tar-replacement-native "

CORE_IMAGE_BASE_INSTALL += "connman"

# Profile specific configuration - default is Tizen common
CORE_IMAGE_BASE_INSTALL += "${IMAGECONFIG}"

#?
#CORE_IMAGE_BASE_INSTALL += "tlm"
#CORE_IMAGE_BASE_INSTALL += "${TLMCONFIG}"


#CORE_IMAGE_BASE_INSTALL += "gum-utils"
#CORE_IMAGE_BASE_INSTALL += "meta-common"
CORE_IMAGE_BASE_INSTALL += "pam"
#CORE_IMAGE_BASE_INSTALL += "user-session-units"
CORE_IMAGE_BASE_INSTALL += "default-ac-domains"
CORE_IMAGE_BASE_INSTALL += "rpm-security-plugin"
CORE_IMAGE_BASE_INSTALL += "config-image"
CORE_IMAGE_BASE_INSTALL += "kernel-modules"
CORE_IMAGE_BASE_INSTALL += "less"
CORE_IMAGE_BASE_INSTALL += "bash"
CORE_IMAGE_BASE_INSTALL += "psmisc"
CORE_IMAGE_BASE_INSTALL += "coreutils"
CORE_IMAGE_BASE_INSTALL += "procps"

CORE_IMAGE_BASE_INSTALL += "screen"
CORE_IMAGE_BASE_INSTALL += "ncurses-terminfo"


export SYSROOT = "${IMAGE_ROOTFS}"


# Set root password to "root"
ROOTFS_POSTPROCESS_COMMAND += "set_root_passwd;"
set_root_passwd() {
   sed 's%^root:[^:]*:%root:wYNffsf6sozwE:%' \
       < ${IMAGE_ROOTFS}/etc/shadow \
       > ${IMAGE_ROOTFS}/etc/shadow.new;
   mv ${IMAGE_ROOTFS}/etc/shadow.new ${IMAGE_ROOTFS}/etc/shadow ;
}
