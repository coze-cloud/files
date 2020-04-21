FROM python:slim

LABEL maintainer="Cozy <cozy@oechsler.it>"
LABEL usage="Barebones FTP server for file management"
LABEL copyright="Copyright 2020 Cozy Hosting - All rights reserved"

ENV FTP_ROOT /home/files
ENV FTP_USER files
ENV FTP_PASS changeme
ENV FTP_PORT 21
ENV FTP_PORTRANGE_LOW 21000
ENV FTP_PORTRANGE_HIGH 21001
ENV FTP_READY="Cozy file server is serving your files."

ADD bin/* /bin/

RUN pip install pyopenssl pyftpdlib && \
    mkdir -pv $FTP_ROOT

EXPOSE $FTP_PORT

ENTRYPOINT /bin/simple-ftp-server
