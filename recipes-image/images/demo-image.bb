require recipes-demo-platform/images/genivi-demo-platform.bb 

IMAGE_FEATURES += " ssh-server-dropbear "

IMAGE_INSTALL += " screen "

IMAGE_INSTALL += " iotivity-example "

IMAGE_INSTALL += " nodejs "


#This package doesn't have any files for the rootfs in it, option needed to create an empty 
# package so when the rootfs image is made it finds the mksd_xxx.deb package and doesn't complain
FILES_${PN} = ""
ALLOW_EMPTY_${PN} = "1"


do_local_patch() {

readme=${WORKDIR}/rootfs/README.txt.md	

cat<<EOF>$readme
URL: https://wiki.tizen.org/wiki/User:Pcoval

CHECK:
EOF

cd ${WORKDIR}/rootfs && find ./lib/systemd/ \
     -wholename './run' -prune -o -wholename './proc' -prune \
     -o -type l -print \
     | perl -nle '-e || print' \
      >> $readme

cat<<EOF > "${WORKDIR}/rootfs/etc/udev/rules.d/99-0eef-0001.rules"
ACTION=="add|change", KERNEL=="event[0-9]*", ENV{ID_VENDOR_ID}=="0eef", ENV{ID_MODEL_ID}=="0001", ENV{ID_INPUT_TOUCHSCREEN}="1", ENV{ID_INPUT_TABLET}="", ENV{ID_INPUT_MOUSE}=""
EOF


# echo 'fs0:\EFI\Boot\bootx64.efi' > "${WORKDIR}/rootfs/startup.nsh"

find ${WORKDIR} -iname "*.efi" >> ${readme}

}


#addtask do_local_patch after do_install
IMAGE_PREPROCESS_COMMAND += "do_local_patch"

