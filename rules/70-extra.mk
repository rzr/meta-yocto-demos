sudo?=$(shell which sudo || echo sudo)
rules?=$(sort $(wildcard rules/??-*.mk))

Makefile: rules
	echo "#! /usr/bin/make -f" > $@
	for rule in ${rules} ; do echo "include $${rule}" >> $@ ; done

rule/debian/setup:
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
 quilt \
 sudo \
 texinfo \
 unzip \
 wget \
 xterm \
 #eol

rule/git/init:
	  git config --global user.email "${email}"
	  git config --global user.name "${name}"

rule/extra/setup:
	ls /etc/debian-release && make ${@D}/debian || echo "TODO: check $@"
	ls ~/.gitconfig && make rule/git/init
