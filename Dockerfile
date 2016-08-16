FROM centos:7
MAINTAINER Przemyslaw Ozgo przemek@m12.io

ENV FTP_USER=admin \
    FTP_PASS=random \
    LOG_STDOUT=false \
    ANONYMOUS_ACCESS=false

RUN \
  rpm --rebuilddb && yum clean all && \
  yum install -y vsftpd && \
  yum clean all

COPY container-files /

EXPOSE 20-21 21100-21110

ENTRYPOINT ["/bootstrap.sh"]
