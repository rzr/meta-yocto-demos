SECTION = "games"
LICENSE = "GPLv2 & Unknown"
LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"
LIC_FILES_CHKSUM += "file://debian/copyright;md5=dfacc2ff27d20063141d067249df9cc9"

SRC_URI = "git://github.com/rzr/pinball.git;protocol=https"
#SRC_URI = "git://git.code.sf.net/p/pinball/code;protocol=https"
SRCREV = "master"
#SRCREV = "v031"
PV = "0.0.0+git${SRCPV}-r1TODO"

S = "${WORKDIR}/git"

DEPENDS += " alsa-lib"
DEPENDS += " libglu"
DEPENDS += " libsdl"
DEPENDS += " libsdl-image"
DEPENDS += " libsdl-mixer"
DEPENDS += " libtool"
DEPENDS += " libvorbis"
DEPENDS += " libx11"
DEPENDS += " tiff"
DEPENDS += " virtual/libgl"

DISTRO_FEATURES_append = " opengl x11"
DISTRO_FEATURES_remove = " wayland" 

PACKAGECONFIG ??= "sdl"
PACKAGECONFIG_append += "sdl-image"
PACKAGECONFIG[sdl] = "--enable-sdl,--disable-sdl,libsdl"
PACKAGECONFIG[sdl-image] = "--enable-sdl-image,--disable-sdl-image,libsdl-image"

PACKAGES = "${PN}"
PACKAGES += "${PN}-staticdev"
PACKAGES += "${PN}-dbg"
PACKAGES += "${PN}-dev"
PACKAGES += "${PN}-data"

inherit pkgconfig autotools-brokensep
REMOVE_LIBTOOL_LA = "0"

do_configure_prepend() {
  cd ${S}
  ./bootstrap
}

do_install_append() {
  rm -rf ${D}/var
}

FILES_${PN}-dev = "\
${includedir}/${PN}/* \
${bindir}/${PN}-config \
"

FILES_${PN}-staticdev = "\
${libdir}/${PN}/lib*.a \
"

FILES_${PN}-dbg = "\
${libdir}/${PN}/.debug/libModule*.so* \
"

FILES_${PN} = "\
${libdir}/${PN}/libModule*.so* \
${libdir}/${PN}/libModule*.la* \
${bindir}/${PN} \
"

FILES_${PN}-data = "\
${datadir}/${PN}/* \
"

RDEPENDS_${PN} += " ${PN}-data"
INSANE_SKIP_${PN} = "dev-so"
