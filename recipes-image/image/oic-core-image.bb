require recipes-image/images/tizen-common-core-image-minimal-dev.bb

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

IMAGE_INSTALL += "iotivity-example"

CORE_IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty"

IMAGE_INSTALL += "screen"
# IMAGE_INSTALL += "strace"
IMAGE_INSTALL += "gdb"


# IMAGE_INSTALL += "ofono ofono-tests"
# PREFERRED_VERSION_ofono = "1.15"

# IMAGE_INSTALL += "g++"
# IMAGE_INSTALL += "gcc"
# IMAGE_INSTALL += "python-scons"

# #inherit scons 

# #  virtual/gettext
# # chrpath-replacement-native
# IMAGE_INSTALL += "boost  expat openssl util-linux curl glib-2.0"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"
