require recipes-image/images/tizen-common-core-image-minimal-dev.bb

IMAGE_INSTALL += "mraa"

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

IMAGE_INSTALL += "iotivity-example"

CORE_IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty"

IMAGE_INSTALL += "screen"

IMAGE_INSTALL += "ofono"
PREFERRED_VERSION_ofono = "git"
IMAGE_INSTALL += "ofono-test"
PREFERRED_VERSION_ofono-test = "git"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"
