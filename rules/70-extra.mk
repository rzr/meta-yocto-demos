#! /usr/bin/make -f
# Author: Philippe Coval <philippe.coval@osg.samsung.com>
# ex: set tabstop=4 noexpandtab:

rules_files?=$(sort $(wildcard rules/??-*.mk))

Makefile: rules/80-phony.mk rules
	echo "#! /usr/bin/make -f" > $@
	for rule in ${rules_files} ; do echo "include $${rule}" >> $@ ; done

/etc/os-release:
	$(error Unsupported OS please report bug)

rule/setup/%: /etc/os-release /etc/%-release

rule/setup/debian: /etc/debian_version
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

rule/setup/ubuntu: rule/setup/debian

rule/setup/fedora: /etc/fedora-release
	sudo yum install \
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

rule/setup/centos: /etc/centos-release
	sudo yum install \
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

rule/setup/opensuse:  /etc/SuSE-release
	sudo zypper install \
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

PHONY: rule/setup/git

rule/setup/git:
	  git config --global user.email "${email}"
	  git config --global user.name "${name}"

rule/setup/lsb: /etc/os-release
	${source} $< && export ID && ${MAKE} rule/setup/$${ID}

~/.gitconfig:
	${MAKE} rule/setup/git

rule/setup/all: rule/setup/lsb ~/.gitconfig


rules/80-phony.mk: rules/50-tasks.mk
	mkdir -p ${@D}
	echo '.PHONY: \' > $@
	grep '^rule/.*:' rules/*.mk | grep -v '%' | cut -d: -f2| sort | sed -e 's|$$| \\|g' >> $@
	echo ' #eol' >> $@
