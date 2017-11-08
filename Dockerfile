#!/usr/bin/docker version
#!/usr/bin/env build .

FROM debian:stable
MAINTAINER Philippe Coval (philippe.coval@osg.samsung.com)

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update \
 && apt-get install -y \
 git make sudo \
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
 locales \
 python \
 \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && df -h . | tee /tmp/df-pre.log

RUN useradd -ms /bin/bash user && whoami
USER user
WORKDIR /home/user/
ARG branch
ENV branch ${branch:-meta/poky/master}
ARG bsp
ENV bsp ${bsp:-generic}
ARG MACHINE
ENV MACHINE ${MACHINE:-qemux86}
ENV URL http://github.com/tizenteam/meta-yocto-demos

RUN pwd \
 && git config --global user.email "nobody@localhost" \
 && git config --global user.name "Nobody" \
 && git clone "${URL}" -b "${branch}" \
 && cd meta-yocto-demos \
 && make bsp="${bsp}" MACHINE="${MACHINE}" \
 && df -h . | tee /tmp/df-post.log \
 && cat /tmp/df-pre.log \
 #eol

COPY /home/user/meta-yocto-demos/build/tmp*/deploy/images ./
