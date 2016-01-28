require recipes-image/images/tizen-core-image-minimal.bb
#require recipes-core/images/core-image-minimal.bb


IMAGE_INSTALL += " \
	kernel-modules \
	"

IMAGE_INSTALL += "mraa"

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

IMAGE_INSTALL += "iotivity-example"

IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty"

include oic-demo-image.inc

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"

