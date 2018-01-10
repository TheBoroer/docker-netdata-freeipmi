FROM debian:jessie
MAINTAINER docker@bo.ro

RUN apt-get update && apt-get -y install git freeipmi libipmimonitoring-dev

RUN git clone https://github.com/firehol/netdata.git /netdata.git
# Initialize IPMI config once by running the tool: ipmimonitoring

RUN echo "deb http://ftp.nl.debian.org/debian/ jessie main" > /etc/apt/sources.list
RUN echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list

RUN cd /netdata.git && chmod +x ./docker-build.sh && sync && sleep 1 && ./docker-build.sh

WORKDIR /

ENV NETDATA_PORT 19999
EXPOSE $NETDATA_PORT

CMD /usr/sbin/netdata -D -s /host -p ${NETDATA_PORT}