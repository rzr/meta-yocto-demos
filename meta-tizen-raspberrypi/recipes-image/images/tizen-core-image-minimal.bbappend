#require recipes-core/images/rpi-hwup-image.bb
# TODO: rep

IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty"


IMAGE_INSTALL += " \
	kernel-modules \
	"

IMAGE_INSTALL += "ncurses screen"


inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"

PACKAGECONFIG += "egl"