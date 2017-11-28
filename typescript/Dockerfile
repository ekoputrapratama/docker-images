FROM ubuntu:16.04
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.9.1

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y unzip zip golang git curl openssl python

ENV GOPATH /usr/local/opt/go
ENV PATH ${GOPATH}:${GOPATH}/bin:${PATH}
RUN go get github.com/prasmussen/gdrive

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
# Install NODE
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
# confirm installation
RUN node -v
RUN npm -v

RUN npm install -g gulp-cli bower typescript typings tslint ts-node
# Set up the application directory
VOLUME ["/projects"]
WORKDIR /projects
#keep the container running to be used in codenvy
CMD tail -f /dev/null
