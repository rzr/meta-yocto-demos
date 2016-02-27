require recipes-image/images/tizen-common-core-image-minimal.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " os-release "
IMAGE_INSTALL += " screen "

