require tizen-base-image.inc

IMAGE_INSTALL += "screen"
IMAGE_INSTALL += "strace"
IMAGE_INSTALL += "gdb"

IMAGE_INSTALL_append = " ofono ofono-test "

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

# depends on mraa (meta-intel)
# IMAGE_INSTALL += "mraa"
IMAGE_INSTALL += "iotivity-sensorboard"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"
