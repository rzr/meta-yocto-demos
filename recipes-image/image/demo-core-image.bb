SUMMARY = "A very basic image"

IMAGE_FEATURES += "package-management ssh-server-dropbear"

LICENSE = "MIT"

inherit core-image distro_features_check

require recipes-image/images/tizen-core-image-minimal.bb

IMAGE_INSTALL += "screen"

IMAGE_INSTALL += "ofono-tests"

PREFERRED_VERSION_ofono = "1.15"
