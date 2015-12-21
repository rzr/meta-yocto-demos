#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

SHELL?=/bin/bash
source?=.
user?=$(shell echo ${USER})
version?=0.0.$(shell date -u +%Y%m%d)${user}

repo?=$(shell which repo || echo ${CURDIR}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo

project_dir?=${CURDIR}
sources_dir?=${project_dir}/sources
sources_layers?=$(wildcard sources/meta-*)
repo_dir?=${project_dir}/.repo
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf
tmp_dir?=tmp
