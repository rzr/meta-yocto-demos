require recipes-core/images/core-image-minimal-dev.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " iotivity "

IMAGE_INSTALL += " iotivity-plugins-samples "
IMAGE_INSTALL += " iotivity-resource "
IMAGE_INSTALL += " iotivity-resource-samples "
IMAGE_INSTALL += " iotivity-service "
IMAGE_INSTALL += " iotivity-service-samples "
IMAGE_INSTALL += " iotivity-tests "

IMAGE_INSTALL += " iotivity-dev "

IMAGE_INSTALL += " iotivity-plugins-staticdev "
IMAGE_INSTALL += " iotivity-resource-dev "
IMAGE_INSTALL += " iotivity-resource-thin-staticdev "
IMAGE_INSTALL += " iotivity-service-dev "
IMAGE_INSTALL += " iotivity-service-staticdev "

IMAGE_INSTALL += " iotivity-simple-client "
IMAGE_INSTALL += " iotivity-sensorboard "
