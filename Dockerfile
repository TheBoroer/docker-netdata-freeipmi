# author  : titpetric
# original: https://github.com/titpetric/netdata

FROM debian:jessie

RUN apt-get update && apt-get -y install freeipmi

RUN mkdir /netdata.git git clone https://github.com/firehol/netdata.git /netdata.git

RUN echo "deb http://ftp.nl.debian.org/debian/ jessie main" > /etc/apt/sources.list
RUN echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list

RUN cd ./netdata.git && chmod +x ./docker-build.sh && sync && sleep 1 && ./docker-build.sh

WORKDIR /

ENV NETDATA_PORT 19999
EXPOSE $NETDATA_PORT

CMD /usr/sbin/netdata -D -s /host -p ${NETDATA_PORT}










FROM ubuntu:16.04

RUN apt-get update &&  apt-get -y install curl htop make gcc libnetfilter-queue-dev git net-tools wget iputils-ping nano

RUN mkdir /home/freebind-source
RUN git clone https://github.com/blechschmidt/freebind.git /home/freebind-source/.
RUN cd /home/freebind-source &&  make install