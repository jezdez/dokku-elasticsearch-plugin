# Elasticsearch Dokku plugin
#
# Version 0.2-blag

FROM charliek/openjdk-jre-7
MAINTAINER blag "drew.hubl@gmail.com"

# Create the elasticsearch user
RUN useradd -m elasticsearch
# Make the data directory
RUN mkdir -p /data/elasticsearch/shared
RUN chown -R elasticsearch:elasticsearch /data/elasticsearch/shared
# Make the plugin directory and make sure the elasticsearch user can install plugins
RUN mkdir -p /usr/share/elasticsearch/plugins
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins

# Install prerequisites for installing elasticsearch
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl sudo
# Add the elasticsearch repository
RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main" >> /etc/apt/sources.list
# Update apt database
RUN apt-get -qq update
# Actually install elasticsearch
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y elasticsearch

# Copy the security configuration
ADD elasticsearch.conf /etc/security/limits.conf
# Add the su command
ADD su /etc/pam.d/su

# Add the entrypoint script and ensure it is executable
ADD run.sh /run.sh
RUN chmod +x /run.sh

# Run all further commands as the elasticsearch user
USER elasticsearch
# Set the elasticsearch version
ENV VERSION 1.2.1
# Install Logstash?
RUN /usr/share/elasticsearch/bin/plugin -i mobz/elasticsearch-head

# Export port 9200
EXPOSE 9200

# Run all further commands, and all commands in the live image, as root
USER root
RUN chown -R root:root /usr/share/elasticsearch/plugins

ENTRYPOINT /run.sh
