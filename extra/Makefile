#! /usr/bin/make -f
docker?=$(shell which docker || echo TODO/docker)
docker_build+=${docker} build --rm

default: all
	pwd

branch?=meta/meta-ocf-automotive/devel
bsp?=raspberrypi
MACHINE?=${bsp}3
url?=http://github.com/tizenteam/meta-yocto-demos.git

export branch
export bsp
export MACHINE

all: docker/build
	pwd

docker/%: Dockerfile
	${docker_build} \
 --build-arg "branch=${branch}" \
 --build-arg "bsp=${bsp}" \
 --build-arg "MACHINE=${MACHINE}" \
 ${<D}


docker-build:
	${docker} build \
 --build-arg "branch=${branch}" \
 --build-arg "bsp=${bsp}" \
 --build-arg "MACHINE=${MACHINE}" \
 "${url}#devel" \
 #eol

TODO/%:
	@echo "#$@"
