PREFERRED_PROVIDER_virtual/libgles2 ?= "userland_git"
PREFERRED_PROVIDER_virtual/mesa ?= "mesa"
PREFERRED_PROVIDER_virtual/libgl ?= "mesa"


CORE_IMAGE_BASE_INSTALL += " screen "
IMAGE_INSTALL += "elementary-tools"
IMAGE_BASE_INSTALL += " python-smartpm "
IMAGE_INSTALL += " weston-clients "
IMAGE_INSTALL += " strace "

IMAGE_INSTALL += " deviced "
IMAGE_INSTALL += " sensord "
IMAGE_INSTALL += " python-smartpm "
IMAGE_INSTALL += " os-release "

IMAGE_INSTALL += " packagegroup-iotivity "

#This package doesn't have any files for the rootfs in it, option needed to create an empty 
# package so when the rootfs image is made it finds the mksd_xxx.deb package and doesn't complain
FILES_${PN} = ""
ALLOW_EMPTY_${PN} = "1"

do_local_patch() {

readme=${WORKDIR}/rootfs/README.txt.md	

cat<<EOF>$readme
URL: https://wiki.tizen.org/wiki/Yocto

CHECK:
EOF

    cd ${WORKDIR}/rootfs && find ./lib/systemd/ \
     -wholename './run' -prune -o -wholename './proc' -prune \
     -o -type l -print \
     | perl -nle '-e || print' \
      >> $readme

l="
/lib/systemd/system/graphical.target.wants/zbooting-done.service
/lib/systemd/system/graphical.target.wants/devicectl-stop@.service
/lib/systemd/system/sockets.target.wants/sensord.socket
/lib/systemd/system/sockets.target.wants/deviced.socket
/lib/systemd/system/multi-user.target.wants/deviced.service
/lib/systemd/system/multi-user.target.wants/sensord.service
"
	for f in $l ; do mv -- "./$f" "./$f.bak" ; done
}

#addtask do_local_patch after do_install

IMAGE_PREPROCESS_COMMAND += "do_local_patch"

