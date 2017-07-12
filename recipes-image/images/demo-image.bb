require recipes-core/images/core-image-minimal-dev.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "
IMAGE_INSTALL += " packagegroup-iotivity "

