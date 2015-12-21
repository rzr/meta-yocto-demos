IMAGE_INSTALL += "iotivity"
IMAGE_INSTALL += "iotivity-simple-client"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password root;"

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P password user;"
