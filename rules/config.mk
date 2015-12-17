#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

MACHINE?=qemux86
machine?=${MACHINE}

branch?=tizen
repo_branch_name?=oic
repo_branch?=sandbox/pcoval/${repo_branch_name}

distro?=${branch}-distro
init_name?=${branch}-common
image?=${branch}-${repo_branch_name}-image

init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

