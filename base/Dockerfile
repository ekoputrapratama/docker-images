FROM ubuntu:19.04
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -qq update

RUN apt-get install -y unzip zip golang git curl wget nano \
  devscripts equivs \
  build-essential \
  libssl-dev \
  apt-transport-https \
  ca-certificates \
  cmake clang

ENV GOPATH /usr/local/opt/go
ENV PATH ${GOPATH}:${GOPATH}/bin:${PATH}

# in docker by default all apt cache will be removed on post install
# by executing this command user can mount their host folder to 
# /tmp/apt to save apt cache for later use
COPY enable-apt-cache.sh /usr/bin/enable-apt-cache

VOLUME ["/tmp/apt"]
VOLUME ["/projects"]

WORKDIR /projects
