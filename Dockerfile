FROM ubuntu:16.04
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>

ARG SGX_DRIVER_URL=https://download.01.org/intel-sgx/linux-2.1.1/ubuntu64-desktop/sgx_linux_x64_driver_1bf50be.bin
ARG SGX_SDK_URL=https://download.01.org/intel-sgx/linux-2.1.1/ubuntu64-desktop/sgx_linux_x64_sdk_2.1.101.42529.bin
ARG SGX_PSW_URL=https://download.01.org/intel-sgx/linux-2.1.1/ubuntu64-desktop/sgx_linux_x64_psw_2.1.101.42337.bin

RUN apt-get update
RUN apt-get install -y build-essential automake autoconf \
    cmake \
    libprotobuf-dev \
    libjsoncpp-dev libjsonrpccpp-dev libjsonrpccpp-tools \
    libsqlite3-0 libsqlite3-dev \
    libtool libboost-all-dev libmicrohttpd-dev libcurl4-openssl-dev \
    liblog4cxx-dev \
    odb wget \
    kmod linux-headers-$(uname -r)

RUN mkdir /root/sgx

WORKDIR /root/sgx

RUN wget -qO sgx_linux_driver.bin $SGX_DRIVER_URL && \
    wget -qO sgx_linux_psw.bin $SGX_PSW_URL && \
    wget -qO sgx_linux_sdk.bin $SGX_SDK_URL && \
    chmod +x sgx_linux_driver.bin && \
    chmod +x sgx_linux_psw.bin && \
    chmod +x sgx_linux_sdk.bin && \
    ./sgx_linux_driver.bin && \
    ./sgx_linux_psw.bin && \
    echo -e 'no\n/opt/intel' | ./sgx_linux_sdk.bin && \
    echo 'source /opt/intel/sgxsdk/environment' >> /root/.bashrc
