require recipes-image/images/tizen-common-core-image-minimal.bb

IMAGE_INSTALL += " \
	kernel-modules \
	"

IMAGE_INSTALL += "mraa"

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

IMAGE_INSTALL += "iotivity-example"

IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty"

IMAGE_INSTALL += "ncurses-terminfo screen"

IMAGE_INSTALL += "ofono"
PREFERRED_VERSION_ofono = "git"
IMAGE_INSTALL += "ofono-test"
PREFERRED_VERSION_ofono-test = "git"

IMAGE_INSTALL += "weston-clients"
IMAGE_BASE_INSTALL += "python-smartpm"
IMAGE_INSTALL += "elementary-tools"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"

IMAGE_INSTALL_append_raspberrypi = " packagegroup-rpi-test"
