require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

IMAGE_INSTALL += "screen"
IMAGE_INSTALL += "ncurses-terminfo"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"
