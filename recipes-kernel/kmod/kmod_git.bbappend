do_install_append () {
	echo "blacklist gma500_gfx" > ${D}${sysconfdir}/modprobe.d/prohibit_gma500_gfx.conf

	cat <<EOF > ${D}${sysconfdir}/modprobe.d/fri2.conf
# http://elinux.org/FRI
blacklist cdc_wdm
blacklist cdc_acm
EOF

}
