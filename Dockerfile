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
