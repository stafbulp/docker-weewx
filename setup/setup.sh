#!/bin/bash

set -e
set -x

cd /tmp/setup
wget "http://www.weewx.com/downloads/released_versions/weewx_${WEEWX_VERSION}-1_all.deb"
sha256sum -c < sums
dpkg -i "weewx_${WEEWX_VERSION}-1_all.deb" || apt-get -y --no-install-recommends -f install
rm "weewx_${WEEWX_VERSION}-1_all.deb"
wget --no-check-certificate -O weewx-interceptor.zip https://github.com/matthewwall/weewx-interceptor/archive/master.zip
/usr/bin/wee_extension --install weewx-interceptor.zip
rm "weewx-interceptor.zip"
/usr/bin/wee_config --reconfigure --driver=user.interceptor --no-prompt
