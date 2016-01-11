SUMMARY = "Iotivity Example"
DESCRIPTION = "Iotivity Server application for Edison which demonstrates Iotivity server capabilities through the integration of an add-on breadboard that hosts temperature, ambient light and LED resources"
HOMEPAGE = "https://www.iotivity.org/"
SECTION = "apps"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

hash = "43d27d1eb89accc097eedd75b188f5f72eeb2f54"

SRC_URI = "git:///home/philippe/var/cache/url/git/ssh/notabug.org/tizen/iotivity-example/src/iotivity-example;branch=tizen;tag=${hash};protocol=file"

S = "${WORKDIR}/git"

LOCAL_OPT_DIR = "/opt"
LOCAL_OPT_DIR_D = "${D}${LOCAL_OPT_DIR}"

DEPENDS = "iotivity "
# mraa"

DEPENDS_${PN} += "iotivity-resource-dev iotivity-resource-thin-staticdev iotivity-plugins-staticdev iotivity-service-dev iotivity-service-staticdev"

BBCLASSEXTEND = "native nativesdk"

EXTRA_OEMAKE = " \
   "

do_configure() {
}

do_compile() {
 cd ${S}
 LANG=C
 export LANG
 unset DISPLAY
 LD_AS_NEEDED=1; export LD_AS_NEEDED ;
 
 oe_runmake config_mraa=0 V=1 all 
}

do_install() {
 export RPM_BUILD_ROOT=${D}
 cd ${S}
 LANG=C
 export LANG
 unset DISPLAY
 rm -rf ${D}
 mkdir -p ${D}
 
 
 oe_runmake \
  install \
  DESTDIR=${LOCAL_OPT_DIR_D} \
  #eol
}

FILES_${PN} += "${LOCAL_OPT_DIR}/${PN}/client"
FILES_${PN}-dbg = "${LOCAL_OPT_DIR}/${PN}/.debug"
RDEPENDS_${PN} += "iotivity-resource"
BBCLASSEXTEND = "native nativesdk"
