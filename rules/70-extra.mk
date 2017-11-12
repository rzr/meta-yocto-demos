#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

/etc/os-release:
	$(error Unsupported OS please report bug)

rule/setup-os/%: /etc/os-release /etc/%-release

apt_get?=apt-get
aptitude?=aptitude

rule/setup-os/debian: /etc/debian_version
	${sudo} ${apt_get} install \
 binutils-gold \
 build-essential \
 ccache \
 chrpath \
 cpio \
 curl \
 diffstat \
 gawk \
 gcc-multilib \
 git-core \
 libattr1-dev \
 libsdl1.2-dev \
 libwayland-dev \
 python \
 quilt \
 sudo \
 texinfo \
 unzip \
 wget \
 xterm \
 #eol

rule/override/setup-os/debian: rule/setup-os/debian
	${sudo} ${apt_get} install aptitude
	${sudo} ${aptitude} install \
 nodejs-legacy \
 qemu-system-x86 \
 qemu-utils \
 #eol

rule/setup-os/ubuntu: rule/setup-os/debian

rule/setup-os/fedora: /etc/fedora-release
	${sudo} yum install \
 SDL-devel \
 bzip2 \
 ccache \
 chrpath \
 cpp \
 curl \
 diffstat \
 diffutils \
 gawk \
 gcc \
 gcc-c++ \
 git \
 glibc-devel \
 gzip \
 make \
 patch \
 perl \
 perl-Data-Dumper \
 perl-Text-ParseWords \
 perl-Thread-Queue \
 python \
 socat \
 tar \
 texinfo \
 unzip \
 wget \
 xterm \
 #eol

rule/setup-os/centos: /etc/centos-release
	${sudo} yum install \
 SDL-devel \
 bzip2 \
 chrpath \
 cpp \
 curl \
 diffstat \
 diffutils \
 gawk \
 gcc \
 gcc-c++ \
 git \
 glibc-devel \
 gzip \
 make \
 patch \
 perl \
 python \
 socat \
 tar \
 texinfo \
 unzip \
 wget \
 xterm \
 #eol

rule/setup-os/opensuse:  /etc/SuSE-release
	${sudo} zypper install \
 chrpath \
 curl \
 diffstat \
 gcc \
 gcc-c++ \
 git \
 libSDL-devel \
 make \
 patch \
 python \
 python-curses \
 python-xml \
 socat \
 texinfo \
 wget \
 xterm \
 #eol

rule/setup-os/lsb: /etc/os-release
	${source} $< && export ID && ${MAKE} rule/setup-os/$${ID}

rule/setup-os: rule/setup-os/lsb
	@echo "log: $@: $^"

rule/setup-git:
	  git config --global user.email "${email}"
	  git config --global user.name "${name}"

~/.gitconfig:
	${MAKE} rule/done/setup-git

rule/setup: rule/done/setup-os ~/.gitconfig
	grep 'user.' ~/.gitconfig

rule/compress:
	find build* -type f \
  -iname "*.hddimg" \
  -o -iname "*.rpi-sdimg" \
  -o -iname "*.rootfs.*-sdimg" \
  | while read file ; do \
	time qemu-img convert -p -c -O qcow2 "$${file}" "$${file}.qcow2" \
  && md5sum "$${file}.qcow2" | tee "$${file}.qcow2.txt" ; \
  done

rule/deploy:
	mkdir -p "deploy-${MACHINE}"
	find build-${MACHINE} -iname "*.qcow2" -exec mv "{}" "deploy-${MACHINE}/" \;
	cd "deploy-${MACHINE}" && ls *.qcow2 | while read file ; do \
  sha1sum "$${file}" | tee "$${file}.tmp" && mv "$${file}.tmp" "$${file}.txt" ; \
  done

DESTDIR?=${CURDIR}/out

rule/install: deploy-${MACHINE}
	install -d ${DESTDIR}/$<
	cp -rf $</* ${DESTDIR}/$</

#TODO
docker?=$(shell which docker || echo "TODO/docker")
docker_build+=${docker} build --rm
url?=http://github.com/tizenteam/meta-yocto-demos.git

default: all
	pwd

export branch
export bsp
export MACHINE

rule/docker: docker/build
	pwd

docker/%: Dockerfile
	${docker_build} \
 --build-arg "branch=${branch}" \
 --build-arg "bsp=${bsp}" \
 --build-arg "MACHINE=${MACHINE}" \
 ${<D}


docker/build/url:
	${docker_build} \
 --build-arg "branch=${branch}" \
 --build-arg "bsp=${bsp}" \
 --build-arg "MACHINE=${MACHINE}" \
 "${url}#${branch}" \
 #eol

TODO/%:
	@echo "#$@"
