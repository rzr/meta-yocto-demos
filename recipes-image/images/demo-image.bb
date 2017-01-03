require recipes-core/images/core-image-minimal-dev.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " os-release "
IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " packagegroup-iotivity "
IMAGE_INSTALL += " iotivity-dev "
IMAGE_INSTALL += " iotivity-simple-client "
IMAGE_INSTALL += " iotivity-node "
