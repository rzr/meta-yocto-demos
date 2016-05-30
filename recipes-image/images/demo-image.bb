require recipes-platform/images/agl-demo-platform.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " iotivity "
IMAGE_INSTALL += " iotivity-tests "
IMAGE_INSTALL += " iotivity-resource-samples "
IMAGE_INSTALL += " iotivity-plugins-samples "
IMAGE_INSTALL += " iotivity-service-samples "

IMAGE_INSTALL += " iotivitymap "