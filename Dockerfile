FROM bl4ck5un/sgx-docker
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>

RUN apt-get update && apt-get --no-install-recommends install -y -qq \
    build-essential \
    automake \
    autoconf \
    cmake \
    curl \
    libtool \
    libboost-all-dev \
    liblog4cxx-dev \
    wget \
    git

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
