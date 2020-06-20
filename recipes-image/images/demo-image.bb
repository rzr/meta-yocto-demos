require recipes-core/images/core-image-minimal.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " kernel-modules"
IMAGE_INSTALL += " os-release "
IMAGE_INSTALL += " screen "

