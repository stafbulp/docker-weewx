#!/bin/sh
if [ ! -e /weewx-conf/weewx.conf ]; then
    echo "-- Copy weewx configuration file --"
    cp /etc/weewx/weewx.conf.original /weewx-conf/weewx.conf
fi
