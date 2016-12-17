FROM kokspflanze/centos-systemd:latest

MAINTAINER "KoKsPfLaNzE" <kokspflanze@protonmail.com>

ENV container docker

# normal updates
RUN yum -y update

# nodejs npm
RUN yum -y install nodejs npm iproute curl crontabs git

# timezone
RUN yum clean all \
 && adduser nodeappuser
 && npm install forever -g
 && rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# create nodejs directory
RUN mkdir -p /opt/data

COPY config/nodejs.service /etc/systemd/system/
COPY config/nodejs.sh /opt/

RUN systemctl enable /etc/systemd/system/nodejs.service

CMD ["/usr/sbin/init"]