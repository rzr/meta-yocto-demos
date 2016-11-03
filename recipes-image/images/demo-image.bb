require recipes-image/images/tizen-common-core-image-minimal.bb

#include oic-demo-image.bb

##! IMAGE_INSTALL += "ncurses-terminfo screen"

##! IMAGE_INSTALL += "ofono"
##! PREFERRED_VERSION_ofono = "git"
##! IMAGE_INSTALL += "ofono-test"
##! PREFERRED_VERSION_ofono-test = "git"

##! #IMAGE_INSTALL += "elementary-tools"
##! #IMAGE_INSTALL += "weston-clients"


##! IMAGE_INSTALL += " \
##! 	kernel-modules \
##! 	"

##! IMAGE_INSTALL += " mraa "

##! #IMAGE_INSTALL += " iotivity "
##! #IMAGE_INSTALL += " iotivity-simple-client "
##! #IMAGE_INSTALL += " iotivity-example "

##! IMAGE_EXTRA_INSTALL += "systemd-serialgetty util-linux-agetty"

##! #include oic-demo-image.inc

##! inherit extrausers
##! EXTRA_USERS_PARAMS = "usermod -P password root;"

##! inherit extrausers
##! EXTRA_USERS_PARAMS = "usermod -P password user;"


#IMAGE_INSTALL += " iotivity-example-gpio "
