FROM jgoerzen/debian-base-security:stretch
MAINTAINER John Goerzen <jgoerzen@complete.org>
COPY setup/ /tmp/setup/
ENV WEEWX_VERSION 3.7.1
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx

VOLUME ["/var/lib/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]

