LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${BPN};endline=2;md5=9fa334646e43f64631e7c473e4c3cc70"
SECTION = "x11"

SRC_URI = "file://${BPN}"
S = "${WORKDIR}"

DEPENDS += " pinball"
PACKAGES = "${PN}"

inherit features_check
REQUIRED_DISTRO_FEATURES = "x11"

RCONFLICTS_${PN} = "matchbox-common"
inherit update-alternatives
ALTERNATIVE_${BPN} = "x-session-manager"
ALTERNATIVE_TARGET[x-session-manager] = "${bindir}/${BPN}"
ALTERNATIVE_PRIORITY = "90"

IMAGE_INSTALL += " packagegroup-pinball"

do_install () {
    install -d ${D}/${bindir}
    install -m 0755 ${S}/${PN} ${D}/${bindir}
}
