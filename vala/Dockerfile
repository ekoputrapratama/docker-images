# Docker file for building deb package

FROM ubuntu:19.04
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y --no-install-recommends unzip zip meson git curl wget sudo \
  && apt-get install -y --no-install-recommends build-essential \
  && apt-get install -y --no-install-recommends libssl-dev \
  && apt-get install -y --no-install-recommends apt-transport-https \
  && apt-get install -y --no-install-recommends ca-certificates \
  && apt-get install -y --no-install-recommends devscripts equivs \
  && apt-get install -y --no-install-recommends cmake clang

VOLUME ["/var/cache/apt/archives"]

WORKDIR /projects
