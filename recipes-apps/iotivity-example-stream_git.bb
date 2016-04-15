SUMMARY = "Iotivity Example Stream"
DESCRIPTION = "Minimalist Iotivity Client/Server application that share a postion"
HOMEPAGE = "https://github.com/TizenTeam/iotivity-example"
SECTION = "apps"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

hash = "c1b04e070f473b05fd439f3f47834af2567c2595"
branch = "sandbox/pcoval/stream"
SRC_URI = "git://github.com/TizenTeam/iotivity-example/;branch=${branch};tag=${hash};protocol=http"

S = "${WORKDIR}/git"

LOCAL_OPT_DIR = "/opt"
LOCAL_OPT_DIR_D = "${D}${LOCAL_OPT_DIR}"

DEPENDS += "iotivity "

DEPENDS_${PN} += "iotivity-resource-dev iotivity-resource-thin-staticdev iotivity-service-dev iotivity-service-staticdev"

BBCLASSEXTEND = "native nativesdk"


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
