require recipes-graphics/images/core-image-x11.bb

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " kernel-modules"
IMAGE_INSTALL += " avahi-daemon "
IMAGE_INSTALL += " os-release "
IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " packagegroup-games-pinball"

IMAGE_INSTALL += " pinball-session"

inherit core-image

#QB_MEM = '${@bb.utils.contains("DISTRO_FEATURES", "opengl", "-m 512", "-m 256", d)}'
