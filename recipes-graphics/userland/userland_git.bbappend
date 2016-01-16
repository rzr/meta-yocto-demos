FILES_${PN}-dev += "${prefix}/lib/pkgconfig/*.pc"
#FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#SRC_URI += "https://github.com/naguirre/meta-raspberrypi/commit/54bdda034c2fd2a5b6c751887d7d9febd75ccb43.patch"


SRC_URI[md5sum] = "0646e0e201b8bc3e4c265da27fd767f9"
SRC_URI[sha256sum] = "c6d0f2c806efdff3741d54705457e3eec63917c088221869595422063be25766"


SRCFORK = "naguirre"
SRCREV = "b886e9725485b0a0b07bd7c0dcf08b0bfea6a288"
SRC_URI = "git://github.com/${SRCFORK}/userland.git;protocol=git;branch=${SRCBRANCH} "
