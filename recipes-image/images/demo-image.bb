require recipes-core/images/core-image-minimal.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " iotivity "
IMAGE_INSTALL += " iotivity iotivity-resource iotivity-service"
IMAGE_INSTALL += " iotivity-resource-samples iotivity-service-samples"

IMAGE_INSTALL += " iotivity-example "
