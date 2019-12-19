#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

# better force in your rule/10-config.mk
SHELL?=/bin/bash

project_name?=meta-yocto-demos
remote?=tizenteam
# TODO
url?=https://github.com/TizenTeam/meta-yocto-demos

user?=$(shell echo ${USER})
log_file?=tmp/build.log
version?=0.0.$(shell date -u +%Y%m%d)${user}
email?=${user}+${project_name}@localhost
name?=${USER} ${project_name} user

branch?=master
branch?=$(shell git rev-parse --abbrev-ref HEAD)

generic?=generic
bsp?=${generic}
MACHINE?=${bsp}x86

# Don't export it could break sub makes
#export MACHINE

machine?=${MACHINE}
machines?=${MACHINE}

os?=oe
os_profile?=${os}
distro?=poky

# TODO: rename to tmp_dir
write_dir?=${CURDIR}
project_dir?=${write_dir}
cache_dir?=${write_dir}
build_dir?=${cache_dir}/build-${machine}
project_relative_dir?=../../
sources_name?=sources-${MACHINE}
sources_dir?=${write_dir}/${sources_name}
machine_tmp_dir?=tmp-${MACHINE}
task_dir?=${machine_tmp_dir}

image_dir?=${build_dir}/tmp/deploy/images/${machine}
conf_file?=${build_dir}/conf/local.conf
bblayers_file?=${build_dir}/conf/bblayers.conf
build_file?=${task_dir}/build.log
sources_layers_conf?=$(sort $(wildcard ${sources_name}/meta-*/conf/layer.conf))
sources_layers_conf+=./conf/layer.conf
sources_layers_dirs?=$(dir ${sources_layers_conf})
sources_layers?=$(sort $(shell dirname $(sources_layers_dirs)))

init_name?=oe
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
image_type?=core
image_base?=${image_type}-image-minimal
image?=${image_base}
images?=${image}

scm?=repo

local_name=localhost

source?=.
sudo?=$(shell which sudo || echo sudo)

rules_files?=$(sort $(wildcard rules/??-*.mk))


distro_machines_dir?=${sources_dir}/${distro}/meta/conf/machine
bsp_machines_dir?=${sources_dir}/meta-${bsp}/conf/machine/
bsp_config_file?=rules/config/bsp/${bsp}/config.mk
machine_config_file?=rules/config/machine/${machine}/config.mk
