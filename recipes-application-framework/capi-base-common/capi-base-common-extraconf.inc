ALLOW_EMPTY_${PN} = "1"

# Fix incorrect file list from upstream .spec file. Avoids
# Bitbake QA error.
capi-base-common-dev_files += "${libdir}/libcapi-base-common.so"

DEPENDS_remove_class-native += "glibc-native"
