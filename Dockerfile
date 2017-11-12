#!/usr/bin/docker version
#!/usr/bin/env build .

FROM debian:stable
MAINTAINER Philippe Coval (philippe.coval@osg.samsung.com)

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN date \
 && df -h . | tee df-pre.log \
 && apt-get update \
 && apt-get install -y sudo locales bash git make \
 && echo "${LC_ALL} UTF-8" > /etc/locale.gen \
 && locale-gen ${LC_ALL} \
 && dpkg-reconfigure locales

RUN useradd -ms /bin/bash user -G sudo
USER user
WORKDIR /home/user/
ENV project_dir /home/user/meta-yocto-demos

ENV URL http://github.com/tizenteam/meta-yocto-demos
ARG branch
ENV branch ${branch:-meta/poky/master}

ENV EMAIL ${EMAIL:-nobody@localhost}
ARG GIT_AUTHOR_EMAIL
ENV GIT_AUTHOR_EMAIL ${EMAIL:-nobody@localhost}
ARG GIT_AUTHOR_NAME
ENV GIT_AUTHOR_NAME ${NAME:-Nobody}


RUN set \
 && git config --global user.name "${GIT_AUTHOR_NAME}" \
 && git config --global user.email "${GIT_AUTHOR_NAME}" \
 && git clone "${URL}" -b "${branch}" \
 && make -C meta-yocto-demos help \
 && cd meta-yocto-demos && find *

USER root
RUN yes | make -C ${project_dir} setup apt_get="apt-get -f" aptitude="aptitude -f"

ARG bsp
ENV bsp ${bsp:-generic}
ARG MACHINE
ENV MACHINE ${MACHINE:-qemux86}

WORKDIR ${project_dir}
USER user
RUN pwd \
 && make -C ${project_dir} bsp="${bsp}" MACHINE="${MACHINE}" \
 && df -h . | tee df-post.log \
 && cat df-pre.log

COPY ${project_dir}/build/tmp*/deploy/images ./tmp/${branch}/images-${bsp}-${MACHINE}
