#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1
bsp_family?=generic
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}
board_family?=qemu
board_variant?=x86
MACHINE?=${board_family}${board_variant}
machine?=${MACHINE}
machines?=${machine} ${machine}-64


os?=oe
os_profile?=
distro=poky
distro_conf?=${distro}-ivi-systemd
extra?=
init_name?=${os}${os_profile}
base_image?=genivi-demo-platform
image?=${base_image}
images?=${base_image} \
 #eol

sources_layers_conf+=
branch?=master


sources_name?=sources-${MACHINE}
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_layers_conf+=${sources_name}/meta-openembedded/meta-oe/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-openembedded/meta-ruby/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-openembedded/meta-filesystems/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-ivi/meta-ivi/conf/layer.conf
sources_layers_conf+=${sources_name}/meta-ivi/meta-ivi-bsp/conf/layer.conf

#sources_layers_conf+=${sources_name}/meta-ivi/meta-ivi-demo/conf/layer.conf

rule/overide/configure-conf: rule/configure-conf
	sed -e 's|^DISTRO.*=.*|DISTRO ?= "poky-ivi-systemd"|g' -i ${conf_file}
	cat rules/config/distro/${distro}/local.conf.in >> ${conf_file}

rule/overide/patch/meta-genivi-demo: ${sources_name}/meta-genivi-demo/conf/layer.conf
	sed -e 's|BBFILE_PRIORITY_genividemo = "7"|BBFILE_PRIORITY_genividemo = "8"|g' -i $<


# https://at.projects.genivi.org/jira/projects/OSSINFR/issues/OSSINFR-30
rule/overide/patch/sources: ${sources_name}
	-find $< -iname "*.bb" -exec grep -H 'git://git.projects.genivi.org' {} \;  | grep -v protocol=http | cut -d: -f1 | xargs -n1  sed -e 's|protocol=git|protocol=http|g' -i 
	-find $< -iname "*.bb" -exec grep -H 'git://git.projects.genivi.org' {} \;  | grep -v protocol=http | cut -d: -f1 | xargs -n1  sed -e 's|\(git://git.projects.genivi.org/[^ "]*\)|\1;protocol=http|g' -i


rule/overide/patch: rule/overide/patch/meta-genivi-demo rule/overide/patch/sources



