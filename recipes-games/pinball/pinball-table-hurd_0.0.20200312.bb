SECTION = "games"
LICENSE = "GPLv2 & Others"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
LIC_FILES_CHKSUM += "file://debian/copyright;md5=5630ce7e380d602f687f3eaf6da973db"

SRC_URI = "git://github.com/rzr/pinball-table-hurd.git;protocol=https"
SRCREV = "0.0.20200312"

#SRC_URI = "git:///home/user/mnt/${BPN};protocol=file"
#SRCREV = "master"
PR = "r0"
PV = "${SRCREV}+git${SRCPV}r9"

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

do_install_append() {
  rm -rf ${D}/var
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
