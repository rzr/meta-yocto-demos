do_install_append() {
  sed -e 's|backend=drm|backend=rpi|g;s|\[ -d /dev/dri \]|\[ -e /dev/vchiq \]|g' -i ${D}/lib/systemd/system/display-manager-run.service
}

