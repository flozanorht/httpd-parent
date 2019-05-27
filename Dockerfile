FROM registry.access.redhat.com/ubi8/ubi:8.0

MAINTAINER Red Hat Training <training@redhat.com>
ENV DOCROOT=/var/www/html

RUN yum --disableplugin=subscription-manager --nodocs -y install httpd \
  && yum --disableplugin=subscription-manager clean all \
  && sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
  && chown -R apache /var/log/httpd /var/run/httpd \
  && echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html


ONBUILD COPY src/ ${DOCROOT}/

EXPOSE 8080
USER apache

CMD httpd -D FOREGROUND

