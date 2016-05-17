require recipes-platform/images/agl-demo-platform.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " mesa-megadriver "

IMAGE_INSTALL += " iotivity "


