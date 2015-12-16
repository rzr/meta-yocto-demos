#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL?=/bin/bash
source?=.
user?=$(shell echo ${USER})
version?=0.0.$(shell date -u +%Y%m%d)${user}

repo?=$(shell which repo || echo ${CURDIR}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo

branch?=dizzy
repo_branch?=${branch}
distro?=poky
init_name?=oe
MACHINE?=qemux86
machine?=${MACHINE}

DL_DIR?=${CURDIR}/cache/download
project_dir?=${CURDIR}
sources_dir?=${project_dir}/sources
repo_dir?=${project_dir}/.repo
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf
image_dir?=${build_dir}/tmp/deploy/images/${machine}
image?=core-image-minimal

conf?=${build_dir}/conf/local.conf
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

