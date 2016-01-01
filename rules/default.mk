#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

# better force in your rule/config.mk
SHELL?=/bin/bash

project_name?=meta-yocto-demos
remote?=tizenteam

user?=$(shell echo ${USER})
log_file?=tmp/build.log
version?=0.0.$(shell date -u +%Y%m%d)${user}
email?=${USER}@localhost
name=${USER}

branch?=$(shell git rev-parse --abbrev-ref HEAD)

generic?=generic
bsp?=${generic}
MACHINE?=${bsp}x86
machine?=${MACHINE}
machines?=${MACHINE}

os?=oe
os_profile?=${os}
distro?=poky

project_dir?=${CURDIR}
cache_dir?=${project_dir}/
build_dir?=${cache_dir}build-${machine}
project_relative_dir?=../../
sources_dir?=${project_dir}/sources
tmp_dir?=tmp

image_dir?=${build_dir}/tmp/deploy/images/${machine}
conf_file?=${build_dir}/conf/local.conf
bblayers_file?=${build_dir}/conf/bblayers.conf
build_file?=${tmp_dir}/build.log
sources_layers_conf?=$(sort $(wildcard sources/meta-*/conf/layer.conf))
sources_layers_conf+=./conf/layer.conf
sources_layers_dirs?=$(dir ${sources_layers_conf})
sources_layers?=$(shell dirname $(sources_layers_dirs))

init_name?=oe
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
image_type?=core
image_base?=${image_type}-image-minimal
image?=${image_base}
images?=${image}

repo_src_file?=default.xml
repo_dir?=${project_dir}
repo_file?=${repo_dir}/${repo_src_file}
repo?=$(shell which repo || echo ${repo_dir}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo

local_name=localhost
local_url?=file://${repo_dir}

source?=.
