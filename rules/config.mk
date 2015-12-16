#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

MACHINE?=qemux86
machine?=${MACHINE}

branch?=tizen
repo_branch?=${branch}

distro?=${branch}-distro
init_name?=${branch}-common
image?=${init_name}-core-image-minimal
init_build_env?=${sources_dir}/${distro}/${init_name}-init-build-env

