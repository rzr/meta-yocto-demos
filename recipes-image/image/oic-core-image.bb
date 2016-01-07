require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL += "screen"
IMAGE_INSTALL += "strace"
IMAGE_INSTALL += "gdb"

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"
