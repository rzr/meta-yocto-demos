#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:


branch?=tizen
repo_branch?=sandbox/pcoval/oic
distro?=${branch}-distro
init_name?=${branch}-common
MACHINE?=qemux86
machine?=${MACHINE}

image_dir?=${build_dir}/tmp/deploy/images/${machine}
image?=${init_name}-core-image-minimal

conf?=${build_dir}/conf/local.conf
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

