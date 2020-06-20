require recipes-core/images/core-image-minimal.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " avahi-daemon "
IMAGE_INSTALL += " kernel-modules"
IMAGE_INSTALL += " os-release "
IMAGE_INSTALL += " screen "

