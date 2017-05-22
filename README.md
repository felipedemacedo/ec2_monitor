# ec2_monitor

# Descrição

Ubuntu 16.04 com o monitor de instâncias instalado. 

https://hub.docker.com/r/felipederodrigues/ec2_monitor/

# Como foi criada essa img ?
## [Dockerfile]
```console
FROM ubuntu:16.04

RUN buildDeps=' \
		zlib1g-dev \
		gcc \
		make \
		git \
		autoconf \
		autogen \
		automake \
		pkg-config \
		uuid-dev \
		curl \
	' \
	&& set -ex \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends 

ADD compile.sh ./
RUN chmod +x compile.sh

EXPOSE 19999

CMD ["sh", "-c", "./compile.sh ; /bin/bash"]
```
## [compile.sh]
```console
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
```


# Como utilizar ?

mkdir -p /home/ubuntu/monitor/netdata

```console
docker run -ti \
-v /home/ubuntu/monitor/netdata:/netdata \
-p 4000:19999 \
--name monitor \
--restart always \
--detach \
felipederodrigues/ec2_monitor:v1
```


Acessar o IP_DO_SERVIDOR:4000 OU IP_DO_SERVIDOR/monitor
