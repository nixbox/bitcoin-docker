FROM ubuntu:latest
MAINTAINER Qasim Javed "qasimj@gmail.com"

# Install dependencies for compiling Bitcoin
RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev git-core

# Add a user named 'bitcoin'
RUN useradd -ms /bin/bash bitcoin
USER bitcoin
WORKDIR /home/bitcoin

# Install compiled Bitcoin
RUN mkdir /home/bitcoin/bin
#CMD cd /home/bitcoin/bitcoin-src/ && make install && export PATH=/home/bitcoin/bin/bin;$PATH && bitcoind -daemon -txindex=1 

