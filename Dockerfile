# Logstash
#
# logstash is a tool for managing events and logs
#
# VERSION               1.4.2

FROM      debian:jessie
MAINTAINER Deni Bertovic "me@denibertovic.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y ca-certificates wget openjdk-7-jre
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O /tmp/logstash.tar.gz 2> /dev/null

RUN tar zxvf /tmp/logstash.tar.gz -C /opt && mv /opt/logstash-1.4.2 /opt/logstash && rm -rf /tmp/logstash.tar.gz 2> /dev/null

RUN [ -d /opt/certs ] || mkdir /opt/certs
RUN [ -f /opt/certs/logstash-forwarder.cr ] || openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout /opt/certs/logstash-forwarder.key -out /opt/certs/logstash-forwarder.cr


ADD start_logstash.sh /usr/local/bin/start_logstash.sh
RUN chmod +x /usr/local/bin/start_logstash.sh

ADD collectd-types.db /opt/collectd-types.db

VOLUME ["/opt/conf", "/opt/certs"]

EXPOSE 514
EXPOSE 5043
EXPOSE 9292

CMD /usr/local/bin/start_logstash.sh

