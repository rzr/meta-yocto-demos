#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

project_name?=meta-yocto-demos
remote?=tizenteam
user?=$(shell echo ${USER})
log_file?=tmp/build.log
version?=0.0.$(shell date -u +%Y%m%d)${user}
email?=${USER}@localhost
name=${USER}

branch?=$(shell git rev-parse --abbrev-ref HEAD)
branch?=master

generic?=generic
bsp?=qemu
MACHINE?=${bsp}x86
machine?=${MACHINE}

os?=${generic}
os_profile?=${generic}
distro?=poky

repo?=$(shell which repo || echo ${CURDIR}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo
repo_branch?=${branch}
repo_src_file?=default.xml
repo_file?=local.xml

init_name?=${os}-${os_profile}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
image_type?=core
image?=${image_type}-image-minimal

project_dir?=${CURDIR}
cache_dir?=${project_dir}/
build_dir?=${cache_dir}build
bblayers_file?=${build_dir}/conf/bblayers.conf
bsp_relative_dir?=../..
image_dir?=${build_dir}/tmp/deploy/images/${machine}
conf_file?=${build_dir}/conf/local.conf


image?=core-image-minimal \
 tizen-common-core-image-minimal \
 tizen-base-image \
 tizen-micro-image

local_name=localhost
local_url?=file://${CURDIR}/
