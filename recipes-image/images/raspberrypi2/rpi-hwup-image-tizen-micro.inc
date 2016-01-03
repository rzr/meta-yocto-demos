SUMMARY = "A headless RaspberryPi image"
LICENSE = "MIT"
DESCRIPTION = "A headless RasberryPi image based on Tizen Micro"

require recipes-core/images/rpi-hwup-image.bb
include recipes-image/tizen-micro-core-image.bb
