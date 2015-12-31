do_install_append () {
	echo "blacklist gma500_gfx" > ${D}${sysconfdir}/modprobe.d/prohibit_gma500_gfx.conf

	cat <<EOF > ${D}${sysconfdir}/modprobe.d/fri2.conf
# http://elinux.org/FRI
blacklist arkfb
blacklist aty128fb
blacklist atyfb
blacklist chsc_sch
blacklist cirrusfb
blacklist cyber2000fb
blacklist gpio_pch
blacklist hgafb
blacklist hisax
blacklist hisax_fcpcipnp
blacklist i2c-matroxfb
blacklist i810fb
blacklist i8xx_tco
blacklist intelfb
blacklist kyrofb
blacklist matroxfb_base
blacklist mb862xxfb
blacklist neofb
blacklist nvidiafb
blacklist pch_can
blacklist pch_phub
blacklist pch_uart
blacklist pm2fb
blacklist pm3fb
blacklist radeonfb
blacklist rivafb
blacklist s3fb
blacklist savagefb
blacklist sisfb
blacklist snd-pcsp
blacklist sstfb
blacklist tdfxfb
blacklist tridentfb
blacklist vga16fb
blacklist viafb
blacklist virgefb
blacklist visor
blacklist vt8623fb

blacklist cdc_wdm
blacklist cdc_acm
EOF

}
