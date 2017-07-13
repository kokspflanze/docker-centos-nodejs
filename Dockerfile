FROM centos:latest

MAINTAINER "KoKsPfLaNzE" <kokspflanze@protonmail.com>

ENV container docker

# normal updates
RUN yum -y update

# tools
RUN yum -y install iproute curl crontabs git \
 && curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - \
 && yum -y install nodejs npm \
 && npm install forever -g

# timezone
RUN yum clean all \
 && adduser nodeappuser \
 && rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime


COPY config/nodejs.service /etc/systemd/system/
COPY config/nodejs.sh /opt/

# create nodejs directory
RUN mkdir -p /opt/data \
 && chmod +x /opt/nodejs.sh

RUN systemctl enable /etc/systemd/system/nodejs.service

CMD ["/usr/sbin/init"]