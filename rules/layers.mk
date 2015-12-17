rule/configure/machine: tmp-configure

tmp-configure: ${bblayers}
	echo "BBLAYERS += \"${sources_dir}/meta-oic\" ">> $<
	echo "BBLAYERS_NON_REMOVABLE += \"${sources_dir}/meta-oic\" ">> $<
	touch $@

