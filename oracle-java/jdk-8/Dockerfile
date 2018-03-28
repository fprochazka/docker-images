FROM ubuntu:16.04

MAINTAINER  Filip Procházka <filip@prochazka.su>

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_VERSION 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get update \
  && apt-get install -y locales \
  && apt-get -y install software-properties-common \
  && add-apt-repository ppa:webupd8team/java \
  && apt-get update \
  && apt-get upgrade -y --no-install-recommends \
  && echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
  && apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VERSION}-installer oracle-java${JAVA_VERSION}-set-default \
  && apt-get clean \
  && rm -rf /var/cache/oracle-jdk${JAVA_VERSION}-installer \
  && update-java-alternatives -s java-8-oracle \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && locale-gen en_US.UTF-8

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
