require recipes-demo-platform/images/genivi-demo-platform.bb 

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " iotivity "

IMAGE_INSTALL += " iotivity-example "
