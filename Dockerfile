FROM ubuntu:16.04



# ------------------------------------------------------
# --- Environments and base directories

# Environments
# - Language
RUN locale-gen en_US.UTF-8
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"

ENV ANDROID_HOME /opt/android-sdk-linux
ENV ANDROID_NDK_HOME /opt/android-sdk-linux/ndk-bundle
# - CI
ENV CI "true"
# - main dirs
ENV SOURCE_DIR "/nerdiex/src"
ENV BRIDGE_WORKDIR "/nerdiex/src"
ENV DEPLOY_DIR "/nerdiex/deploy"
ENV CACHE_DIR "/nerdiex/cache"

# create base dirs
RUN mkdir -p /nerdiex/src
RUN mkdir -p /nerdiex/deploy
RUN mkdir -p /nerdiex/cache

# prep dir
RUN mkdir -p /nerdiex/prep
WORKDIR /nerdiex/prep


# ------------------------------------------------------
# --- Base pre-installed tools
RUN apt-get update -qq
# Requiered for Bitrise CLI
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mercurial curl wget rsync sudo expect
# Common, useful
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install zip
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tree
# For PPAs
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common


# ------------------------------------------------------
# --- Pre-installed but not through apt-get

# install Ruby from source
#  from source: mainly because of GEM native extensions,
#  this is the most reliable way to use Ruby no Ubuntu if GEM native extensions are required
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
RUN wget -q http://cache.ruby-lang.org/pub/ruby/ruby-2.2.4.tar.gz
RUN tar -xvzf ruby-2.2.4.tar.gz
RUN cd ruby-2.2.4 && ./configure --prefix=/usr/local && make && make install
# cleanup
RUN rm -rf ruby-2.2.4
RUN rm ruby-2.2.4.tar.gz

RUN gem install bundler --no-document

# ------------------------------------------------------
# --- Install required tools


# Base (non android specific) tools
# -> should be added to bitriseio/docker-bitrise-base

# Dependencies to execute Android builds
RUN dpkg --add-architecture i386
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386


# ------------------------------------------------------
# --- Download Android SDK tools into $ANDROID_HOME

RUN cd /opt && wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O android-sdk.tgz
RUN cd /opt && tar -xvzf android-sdk.tgz
RUN cd /opt && rm -f android-sdk.tgz

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# ------------------------------------------------------
# --- Install Android SDKs and other build packages

# Other tools and resources of Android SDK
#  you should only install the packages you need!
# To get a full list of available options you can use:
#  android list sdk --no-ui --all --extended
# (!!!) Only install one package at a time, as "echo y" will only work for one license!
#       If you don't do it this way you might get "Unknown response" in the logs,
#         but the android SDK tool **won't** fail, it'll just **NOT** install the package.
RUN echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-android-support | grep 'package installed'

# SDKs
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter android-25 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-24 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-23 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-22 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-21 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-20 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-19 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-17 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-15 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-10 | grep 'package installed'

# build tools
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.3 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.3 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-22.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-21.1.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-20.0.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-19.1.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-17.0.0 | grep 'package installed'

# Android System Images, for emulators
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-24 | grep 'package installed'
#RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-22 | grep 'package installed'
#RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-21 | grep 'package installed'
#RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-19 | grep 'package installed'
#RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-17 | grep 'package installed'
#RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-15 | grep 'package installed'

# Extras
RUN echo y | android update sdk --no-ui --all --filter extra-android-m2repository | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-google-m2repository | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-google-google_play_services | grep 'package installed'

# google apis
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-23 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-22 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-21 | grep 'package installed'


# ------------------------------------------------------
# --- Install Gradle from PPA

# Gradle PPA
RUN apt-get update
RUN apt-get -y install gradle
RUN gradle -v

# ------------------------------------------------------
# --- Install Maven 3 from PPA

RUN apt-get purge maven maven2
RUN apt-get update
RUN apt-get -y install maven
RUN mvn --version

# ------------------------------------------------------
# --- Install Fastlane

RUN gem install fastlane --no-document
RUN fastlane --version

# ------------------------------------------------------
# --- Cleanup and rev num


# ------------------------------------------------------
# --- Android NDK

# download
RUN mkdir /opt/android-ndk-tmp
RUN cd /opt/android-ndk-tmp && wget -q https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip
# uncompress
RUN cd /opt/android-ndk-tmp && unzip -q android-ndk-r13b-linux-x86_64.zip
# move to its final location
RUN cd /opt/android-ndk-tmp && mv ./android-ndk-r13b ${ANDROID_NDK_HOME}
# remove temp dir
RUN rm -rf /opt/android-ndk-tmp
# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# ------------------------------------------------------
# --- Android CMake

# download
RUN mkdir /opt/android-cmake-tmp
RUN cd /opt/android-cmake-tmp && wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
# uncompress
RUN cd /opt/android-cmake-tmp && unzip -q android-cmake.zip -d android-cmake
# move to its final location
RUN cd /opt/android-cmake-tmp && mv ./android-cmake ${ANDROID_HOME}/cmake
# remove temp dir
RUN rm -rf /opt/android-cmake-tmp
# add to PATH
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin

RUN apt-get clean

RUN chown -R 1000:1000 $ANDROID_HOME
VOLUME ["/opt/android-sdk-linux"]
