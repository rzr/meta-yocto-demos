DESCRIPTION = "Pinball Game"
inherit packagegroup

PACKAGES = "\
    packagegroup-games-pinball \
    "

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_${PN} += "\
pinball \
pinball-dev \
pinball-table-gnu \
pinball-table-hurd \
"
