SECTION = "games"
LICENSE = "GPLv2 & Unknown"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
LIC_FILES_CHKSUM += "file://debian/copyright;md5=7d2f80a6e11a2648d4657afdb89d05a8"

SRC_URI = "git://github.com/rzr/pinball-table-gnu.git;protocol=https"
PV = "0.0.0+git${SRCPV}"
SRCREV = "0.0.20200601"

#SRC_URI = "git:///home/user/mnt/${BPN};protocol=file"
#SRCREV = "master"

S = "${WORKDIR}/git"

DEPENDS += " libsdl"
DEPENDS += " libtool"
DEPENDS += " pinball"

DISTRO_FEATURES_append = " opengl x11"
DISTRO_FEATURES_remove = " wayland" 

PACKAGECONFIG ??= "sdl"
PACKAGECONFIG[sdl] = "--enable-sdl,--disable-sdl,libsdl"

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

FILES_${PN}-dev = "\
${includedir}/${PN}/* \
"

FILES_${PN}-staticdev = "\
${libdir}/pinball/lib*.a \
"
    
FILES_${PN}-dbg = "\
${libdir}/pinball/.debug/libModule*.so* \
"

FILES_${PN} = "\
${libdir}/pinball/libModule*.so* \
${libdir}/pinball/libModule*.la \
"

FILES_${PN}-data = "\
${datadir}/pinball/*/* \
"

RDEPENDS_${PN} += " pinball"
RDEPENDS_${PN} += " ${PN}-data"
INSANE_SKIP_${PN} = "dev-so"
