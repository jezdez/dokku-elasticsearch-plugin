FROM ubuntu-debootstrap:14.04
MAINTAINER Vincent Fretin "vincentfretin@ecreall.com"

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless curl sudo && \
  rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y elasticsearch && \
    rm -rf /var/lib/apt/lists/*
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 9200 9300
VOLUME ["/var/lib/elasticsearch"]
CMD ["/usr/local/bin/run"]
