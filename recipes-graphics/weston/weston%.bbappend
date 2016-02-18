EXTRA_OECONF_append_raspberrypi += "--enable-rpi-compositor"
PACKAGECONFIG_remove_olinuxino-a20 += "egl wayland-egl"
PACKAGECONFIG_remove_fri2-noemgd += "cairo-glesv2 drm"
