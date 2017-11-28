FROM ubuntu:16.04
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.9.1
ENV YARN_VERSION 1.3.2
ENV YARN_CACHE_FOLDER=/root/.yarn-cache

RUN sudo apt-get update
RUN sudo apt-get -qq update
RUN sudo apt-get install -y unzip zip golang \
    git \
    curl \
    wget \
    build-essential \
    libssl-dev \
    apt-transport-https \
    ca-certificates \
    libgtk2.0-dev \
    libxtst-dev \
    libxss1 \
    libgconf2-dev \
    libnss3-dev \
    libasound2-dev \
    xvfb \
    xfonts-75dpi \
    xfonts-base \
    && apt-get install -y gnupg \
    hicolor-icon-theme \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpango1.0-0 \
    libpulse0 \
    libv4l-0 \
    fonts-symbola --no-install-recommends

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install --no-install-recommends -y yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
# Install NODE
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
# confirm installation
RUN node -v
RUN npm -v

