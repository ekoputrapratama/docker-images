FROM eclipse/selenium
MAINTAINER Muhammad Sayuti "muhammad.sayuti94@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update
RUN sudo apt-get -qq update
RUN sudo apt-get install -y nodejs npm unzip zip golang git curl wget
ENV GOPATH /usr/local/opt/go
ENV PATH ${GOPATH}:${GOPATH}/bin:${PATH}
RUN sudo go get github.com/prasmussen/gdrive
# TODO could uninstall some build dependencies

# fucking debian installs `node` as `nodejs`
RUN sudo update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN sudo npm install -g electron typescript tslint gulp gulp-if bower

WORKDIR /projects

CMD if [ ! -z ${WEBDRIVER_VERSION+x} ]; then \
        wget -O /home/user/chromedriver_linux64.zip -q http://chromedriver.storage.googleapis.com/${WEBDRIVER_VERSION}/chromedriver_linux64.zip; \
        unzip -o -q /home/user/chromedriver_linux64.zip  -d /home/user; \
        rm /home/user/chromedriver_linux64.zip; \
    fi && \
    /usr/bin/supervisord -c /opt/supervisord.conf & \
    cd /home/user && sleep 3 && \
    /home/user/chromedriver --port=4444 --whitelisted-ips='' & \
    sleep 365d
