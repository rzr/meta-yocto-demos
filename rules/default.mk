#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

project_name?=meta-yocto-demos
remote?=tizenteam
user?=$(shell echo ${USER})
log_file?=tmp/build.log
version?=0.0.$(shell date -u +%Y%m%d)${user}

branch?=$(shell git rev-parse --abbrev-ref HEAD)
branch?=master

generic?=generic
bsp?=qemu
MACHINE?=${bsp}x86
machine?=${MACHINE}

os?=${generic}
os_profile?=${generic}
distro?=poky
distro_branch?=${os}
repo?=$(shell which repo || echo ${CURDIR}/repo)
repo_url?=https://storage.googleapis.com/git-repo-downloads/repo
repo_branch?=${branch}
repo_src_file?=default.xml
repo_file?=${repo_src_file}.tmp

init_name?=${os}-${os_profile}
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
image_base?=core-image-minimal
image?=${image_base}

project_dir?=${CURDIR}
cache_dir?=${project_dir}/
build_dir?=${cache_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf
bsp_relative_dir?=../..
image_dir?=${build_dir}/tmp/deploy/images/${machine}
conf?=${build_dir}/conf/local.conf


