FROM ubuntu:16.04
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y nodejs npm  unzip zip golang git curl openssl python

ENV GOPATH /usr/local/opt/go
ENV PATH ${GOPATH}:${GOPATH}/bin:${PATH}
RUN go get github.com/prasmussen/gdrive
# TODO could uninstall some build dependencies

# fucking debian installs `node` as `nodejs`
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN npm install -g babel babel-cli gulp-babel gulp-cli bower typescript typings tslint mongodb express
# Set up the application directory
VOLUME ["/projects"]
WORKDIR /projects
CMD ["npm", "-v"]
#keep the container running to be used in codenvy
CMD tail -f /dev/null
