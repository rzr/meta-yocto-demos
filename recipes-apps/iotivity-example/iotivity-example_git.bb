SUMMARY = "Iotivity Example"
DESCRIPTION = "Iotivity Server application for Edison which demonstrates Iotivity server capabilities through the integration of an add-on breadboard that hosts temperature, ambient light and LED resources"
HOMEPAGE = "https://www.iotivity.org/"
SECTION = "apps"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

hash = "1a69a21646324ea70e0d892d5f26e7978bbf2290"

SRC_URI = "git://notabug.org/tizen/iotivity-example/;branch=sandbox/pcoval/devel;tag=${hash};protocol=git"

S = "${WORKDIR}/git"

LOCAL_OPT_DIR = "/opt"
LOCAL_OPT_DIR_D = "${D}${LOCAL_OPT_DIR}"

DEPENDS += "iotivity "

config_mraa="1"
DEPENDS += "mraa"
RDEPENDS_${PN} += "mraa"

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
 
 oe_runmake all \
  config_mraa=${config_mraa} 
}

do_install() {
 export RPM_BUILD_ROOT=${D}
 cd ${S}
 LANG=C
 export LANG
 unset DISPLAY
 rm -rf ${D}
 install -d ${D}
 oe_runmake \
  install \
  DESTDIR=${LOCAL_OPT_DIR_D} \
  config_mraa=${config_mraa} \
  #eol
}

FILES_${PN} += "${LOCAL_OPT_DIR}/${PN}/client"
FILES_${PN} += "${LOCAL_OPT_DIR}/${PN}/server"
FILES_${PN}-dbg = "${LOCAL_OPT_DIR}/${PN}/.debug"
RDEPENDS_${PN} += "iotivity-resource"
BBCLASSEXTEND = "native nativesdk"
