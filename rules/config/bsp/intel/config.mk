#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL=/bin/bash
V=1


bsp_family?=intel
bsp_variant?=
bsp?=${bsp_family}${bsp_variant}

board_family?=${bsp}-corei7
board_variant?=-64
MACHINE?=${board_family}${board_variant}

machine?=${MACHINE}
machines?=${machine}
os?=oe
os_profile?=
distro?=poky
distro_conf?=${distro}-agl
extra?=
init_name?=${os}${os_profile}
base_image?=agl-demo-platform
image?=demo-image
images?=${image} ${base_image} \
 #eol
branch?=master
sources_name?=sources-${MACHINE}
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-agl/meta-ivi-common/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-agl/meta-agl/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-openembedded/meta-oe/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-openembedded/meta-efl/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-openembedded/meta-multimedia/conf/layer.conf))
sources_layers_conf+=$(sort $(wildcard ${sources_name}/meta-openembedded/meta-ruby/conf/layer.conf))

project_relative_dir?=../sources/poky/
build_dir?=${CURDIR}/build-${MACHINE}
conf_dir?=${build_dir}/conf

rule/overide/configure-conf: rules/config/bsp/${bsp}/local.conf ${conf_dir}
	sed -e "s|^MACHINE ??=.*|MACHINE ??= \"${MACHINE}\"|g"  < $< > ${conf_file}

rule/overide/configure-bblayers: ${sources_name}/meta-agl-demo/templates/${MACHINE}/conf/bblayers.conf.sample ${conf_dir}
	echo "RELATIVE_DIR := \"\$${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/${project_relative_dir}')}\"" > ${bblayers_file}.mine
	sed -e "s|##OEROOT##|\$${RELATIVE_DIR}|g"  < $< >> ${bblayers_file}.mine
	echo "BBLAYERS += \" \$${RELATIVE_DIR}/../.. \"" >> ${bblayers_file}.mine
	echo "BBLAYERS += \" \$${RELATIVE_DIR}/../meta-ocf-automotive \"" >> ${bblayers_file}.mine
	echo "BBLAYERS += \" \$${RELATIVE_DIR}/../meta-ocf-automotive/meta-agl/ \"" >> ${bblayers_file}.mine
	cp -av ${bblayers_file}.mine ${bblayers_file}
	ln -fs ../${sources_name} ${build_dir}/sources
	ls ${build_dir}/conf/${project_relative_dir}


rule/overide/configure-conf/distro: rule/configure-conf ${conf_file}
	sed -e 's|^DISTRO.*=.*|DISTRO ?= "poky-agl"|g' -i ${conf_file}

rule/overide/sub-configure: rule/overide/configure-bblayers rule/overide/configure-conf


