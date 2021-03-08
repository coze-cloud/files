FROM ubuntu:latest

LABEL maintainer="Cozy <cozy@oechsler.it>"
LABEL usage="Barebones SFTP server for file management"
LABEL copyright="Copyright 2021 Cozy Hosting - All rights reserved"

RUN apt-get update && apt-get install -y \
  openssh-server \
  mcrypt \
  && mkdir /var/run/sshd \
  && chmod 0755 /var/run/sshd \
  && mkdir -p /data/mounts \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && mkdir /ssh/

ADD start.sh /usr/local/bin/start.sh
ADD sshd_config /etc/ssh/sshd_config

ADD README.txt /data/README.txt

VOLUME /data/mounts
EXPOSE 22

ENTRYPOINT ["/bin/bash", "/usr/local/bin/start.sh"]
