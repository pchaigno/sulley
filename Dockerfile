FROM ubuntu:14.04
MAINTAINER Paul Chaignon <paul.chaignon@gmail.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y python flex bison curl gcc make unzip libpcap-dev python-pcapy

# Install libpcap-1.4.0
WORKDIR /
RUN curl http://www.tcpdump.org/release/libpcap-1.4.0.tar.gz > libpcap-1.4.0.tar.gz
RUN tar -zxvf libpcap-1.4.0.tar.gz
WORKDIR /libpcap-1.4.0
RUN ./configure
RUN make
RUN make install

# Install distorm3
WORKDIR /
RUN curl https://distorm.googlecode.com/files/distorm3.zip > distorm3.zip
RUN unzip distorm3.zip
WORKDIR /distorm3
RUN python setup.py build
RUN python setup.py build install

# Download vtrace
WORKDIR /
RUN curl http://visi.kenshoto.com/static/releases/vdb_20120806.zip > vdb_20120806.zip
RUN unzip vdb_20120806.zip
RUN mv vdb_20120806 vdb

ADD . /sulley
WORKDIR /sulley
