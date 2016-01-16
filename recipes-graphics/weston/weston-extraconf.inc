RDEPENDS_${PN} += "xkeyboard-config"
RRECOMMENDS_${PN} = "liberation-fonts"

RDEPENDS_${PN}_remove = "weston-startup"

SRC_URI += "file://make-lcms-explicitly-configurable.patch"
SRC_URI += "file://make-libwebp-explicitly-configurable.patch"

PACKAGECONFIG ?= ""
PACKAGECONFIG += "egl"
PACKAGECONFIG += "wayland"
PACKAGECONFIG += "wayland-egl"

PACKAGECONFIG[egl] += " \
 --enable-egl --enable-simple-egl-clients, \
 --disable-egl --disable-simple-egl-clients, \
 virtual/egl \
"

PACKAGECONFIG[wayland-egl] += " \
 --enable-drm-compositor --enable-egl-backend, \
 --disable-drm-compositor --disable-egl-backend, \ 
 virtual/egl \
"

PACKAGECONFIG[wayland] = " \
 --enable-wayland-compositor,\
 --disable-wayland-compositor, \
  wayland \
"

PACKAGECONFIG[cairo-glesv2] += "--with-cairo=glesv2, , virtual/libgles2"

EXTRA_OECONF += "   \
                    --disable-vaapi-recorder \
                    --enable-weston-launch \
                    --enable-sys-uid \
                    --enable-fbdev-compositor \
                    --disable-headless-compositor \
                    --enable-setuid-install \
                    --enable-demo-clients-install \
                    --disable-lcms \
                    --disable-webp \
                    "

EXTRA_OECONF += "--disable-rdp-compositor"
EXTRA_OECONF += "--disable-dbus"
EXTRA_OECONF += "--enable-simple-clients --enable-clients"
EXTRA_OECONF += "--disable-static --disable-setuid-install --disable-libunwind"
EXTRA_OECONF += "--disable-xwayland --disable-xwayland-test --disable-x11-compositor"
EXTRA_OECONF += "--disable-rpi-compositor"


do_configure_prepend() {
    sed -i 's/PKG_CHECK_MODULES(WAYLAND_SCANNER, wayland-scanner)//' configure.ac
}

pkg_preinst_${PN}() {
}

export libexecdir="${prefix}/libexec"

FILES_${PN} += "${prefix}/lib/weston/cms-static.so"

FILES_${PN} += "${prefix}/bin/weston-scaler"
FILES_${PN} += "${prefix}/bin/weston-stacking"
FILES_${PN} += "${prefix}/bin/weston-multi-resource"
