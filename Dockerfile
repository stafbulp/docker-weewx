FROM jgoerzen/debian-base-security:buster
MAINTAINER Staffan Lindmark <staffan@lindmarken.se>
COPY setup/ /tmp/setup/
ENV WEEWX_VERSION 3.9.1
ENV DEBIAN_FRONTEND noninteractive
# The font file is used for the generated images
#RUN mv /tmp/setup/initial.sh /usr/local/bin/ && chmod +x /usr/local/bin/initial.sh
RUN cp -f /tmp/setup/boot-debian-base /usr/local/bin/ && chmod +x /usr/local/bin/boot-debian-base
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync fonts-freefont-ttf && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx
RUN mkdir /weewx-conf
RUN mv /etc/weewx/weewx.conf /etc/weewx/weewx.conf.original
RUN ln -s /weewx-conf/weewx.conf /etc/weewx/weewx.conf
VOLUME ["/var/lib/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]
#CMD ["/usr/local/bin/initial.sh"]
