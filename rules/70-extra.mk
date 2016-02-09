#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:


/etc/os-release:
	$(error Unsupported OS please report bug)

rule/setup-os/%: /etc/os-release /etc/%-release

rule/setup-os/debian: /etc/debian_version
	${sudo} apt-get install \
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
 nodejs-legacy \
 quilt \
 sudo \
 texinfo \
 unzip \
 wget \
 xterm \
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

rule/setup/git:
	  git config --global user.email "${email}"
	  git config --global user.name "${name}"

~/.gitconfig:
	${MAKE} rule/setup/git

rule/setup: rule/setup-os/lsb ~/.gitconfig
	grep 'user.' ~/.gitconfig
