#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-
# SPDX-License-Identifier: MIT

FROM debian:10
MAINTAINER Philippe Coval (rzr@users.sf.net)

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG ${LC_ALL}

RUN echo "# log: Configuring locales" \
  && set -x \
  && apt-get update \
  && apt-get install -y locales \
  && echo "${LC_ALL} UTF-8" | tee /etc/locale.gen \
  && locale-gen ${LC_ALL} \
  && dpkg-reconfigure locales \
  && sync

ENV project meta-yocto-demos
ENV workdir /usr/local/src/${project}/

RUN echo "# log: ${project}: Setup system" \
  && set -x \
  && apt-get update -y \
  && apt-get install -y \
  make sudo \
  && apt-get clean \
  && sync

RUN echo "# log: ${project}: Build" \
  && set -x \
  && useradd -ms /bin/bash "${project}" \
  && sync

WORKDIR ${workdir}
ADD rules ${workdir}/rules
ADD *akefile ${workdir}/
RUN echo "# log: ${project}: Setup system" \
  && set -x \
  && id && make setup \
  && chown -R ${project} . \
  && sync

ADD . ${workdir}
RUN echo "# log: ${project}: Setup system" \
  && set -x \
  && chown -Rv ${project} . \
  && sync

ENV EMAIL me@${project}.github.io
USER "${project}"
WORKDIR ${workdir}
RUN echo "# log: ${project}: Build" \
  && set -x \
  && export EMAIL=${EMAIL} \
  && git config --global user.name "${project}" \
  && git config --global user.email "${EMAIL}" \
  && ls -l && make \
  && sync
