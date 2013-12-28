# Elasticsearch Dokku plugin
#
# Version 0.1

FROM charliek/openjdk-jre-7
MAINTAINER Jannis Leidel "jannis@leidel.info"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl sudo
RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main" >> /etc/apt/sources.list
RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y elasticsearch
ADD run.sh /usr/local/bin/elasticsearch
RUN chmod +x /usr/local/bin/elasticsearch

EXPOSE 9200 9300
