FROM bl4ck5un/sgx-docker
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>

RUN apt-get update && apt-get install -y \
    build-essential automake autoconf \
    cmake \
    libjsoncpp-dev libjsonrpccpp-dev libjsonrpccpp-tools \
    libsqlite3-0 libsqlite3-dev \
    libtool libboost-all-dev libmicrohttpd-dev libcurl4-openssl-dev \
    liblog4cxx-dev \
    odb wget \
