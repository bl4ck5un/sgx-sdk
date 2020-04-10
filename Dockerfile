FROM bl4ck5un/sgx-docker
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>

RUN apt-get update && apt-get install -y \
    build-essential automake autoconf \
    cmake \
    libjsoncpp-dev libjsonrpccpp-dev libjsonrpccpp-tools \
    libsqlite3-0 libsqlite3-dev \
    libtool libboost-all-dev libmicrohttpd-dev libcurl4-openssl-dev \
    liblog4cxx-dev \
    odb wget curl git

RUN git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc ~/grpc && \
	cd ~/grpc && \
	git submodule update --init && \
	cd ~/grpc/third_party/protobuf && \
	./autogen.sh && \
	./configure --prefix=/opt/protobuf && \
	make -j $(nproc) && \
	make install && \
	cd ~/grpc && make -j $(nproc) PROTOC=/opt/protobuf/bin/protoc && \
	make prefix=/opt/grpc install && \
	rm -rf ~/grpc

RUN ldconfig
