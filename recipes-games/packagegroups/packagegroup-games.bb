DESCRIPTION = "Games"
inherit packagegroup

PACKAGES = "\
packagegroup-games \
"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
atanks \
astromenace \
chromium-bsu \
pingus \
"
