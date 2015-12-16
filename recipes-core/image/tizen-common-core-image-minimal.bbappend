IMAGE_INSTALL += "screen"

IMAGE_INSTALL_append = " ofono ofono-test "

IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

# depends on mraa (meta-intel)
# IMAGE_INSTALL += "mraa"
IMAGE_INSTALL += "iotivity-sensorboard"
