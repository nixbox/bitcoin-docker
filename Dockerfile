FROM ubuntu:latest
MAINTAINER Qasim Javed "qasimj@gmail.com"

# Install dependencies for compiling Bitcoin
RUN sed -i -e "s/\/\/archive\.ubuntu/\/\/us.archive.ubuntu/" /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev libdb5.3++-dev git-core lcov

# Add a user named 'bitcoin'
RUN useradd -ms /bin/bash bitcoin
USER bitcoin
WORKDIR /home/bitcoin

# Clone bitcoin code
RUN git clone https://github.com/bitcoin/bitcoin bitcoin-src
WORKDIR bitcoin-src
RUN git checkout v0.15.1
RUN ./autogen.sh
RUN ./configure --enable-lcov --with-incompatible-bdb
RUN make -j 32
USER root
RUN make install
ENV PATH /home/bitcoin/bitcoin/bin:$PATH

# Install compiled Bitcoin
USER bitcoin
CMD /usr/local/bin/bitcoind -txindex -printtoconsole -debug=1
