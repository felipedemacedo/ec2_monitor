#!/bin/sh

set -x

pwd

DIRECTORY="/netdata"
RELATIVE_URL="monitor"

if [ "$(ls -A $DIRECTORY)" ]; then
    echo "$DIRECTORY is not Empty"
else
    echo "$DIRECTORY is Empty"
    # http://stackoverflow.com/questions/23885449/unable-to-resolve-unable-to-get-local-issuer-certificate-using-git-on-windows
    git config --global http.sslVerify false
    git clone https://github.com/firehol/netdata
fi

cd /netdata
./netdata-installer.sh --dont-wait


if [ "$RELATIVE_URL" != "" ]
then
    cat /usr/share/netdata/web/index.html | grep -e "dashboard.js"
    #sed -i.bak s/'=\"dashboard.js'/'=\"$RELATIVE_URL\/dashboard.js'/g /usr/share/netdata/web/index.html
    sed -i.bak "s/=\"dashboard.js/=\"$RELATIVE_URL\/dashboard.js/g" /usr/share/netdata/web/index.html
    cat /usr/share/netdata/web/index.html | grep -e "dashboard.js"
fi
