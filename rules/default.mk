#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

branch?=tizen
repo_branch?=${branch}
distro?=${branch}-distro
init_name?=${branch}
MACHINE?=qemux86
machine?=${MACHINE}

project_dir?=${CURDIR}
build_dir?=${project_dir}/build
bblayers?=${build_dir}/conf/bblayers.conf

init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env
image_dir?=${build_dir}/tmp/deploy/images/${machine}
conf?=${build_dir}/conf/local.conf
image?=core-image-minimal
