# This image is based on https://github.com/blocknetdx/dockerimages/blob/master/ltc/Dockerfile 
# but adapted to download a compiled binary instead of using sources to compile.

FROM ubuntu:focal AS builder

ARG ltc_version=0.18.1

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     wget gnupg ca-certificates\
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/blockchain

## Import gpg key of litecoin devs, download and verify the .asc attached with the release, if it is correct continue downloading the release.
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys FE3348877809386C && \
    wget https://download.litecoin.org/litecoin-${ltc_version}/linux/litecoin-${ltc_version}-linux-signatures.asc && \
    gpg --verify litecoin-${ltc_version}-linux-signatures.asc  && \
    wget https://download.litecoin.org/litecoin-${ltc_version}/linux/litecoin-${ltc_version}-x86_64-linux-gnu.tar.gz && \
    tar -xvzf litecoin-${ltc_version}-x86_64-linux-gnu.tar.gz litecoin-${ltc_version}/bin --strip-components=2 && \
    rm litecoin-${ltc_version}-x86_64-linux-gnu.tar.gz litecoin-${ltc_version}-linux-signatures.asc

# Set a default config so the daemon can start with a bare instruction. Other option would be to copy the generate file at buildtime.
RUN mkdir /opt/blockchain/data /opt/blockchain/config && \
    echo "datadir=/opt/blockchain/data  \n\
                                            \n\
    dbcache=256                             \n\
    maxmempool=512                          \n\
                                            \n\
    port=9333    # testnet: 19333           \n\
    rpcport=9332 # testnet: 19332           \n\
                                            \n\
    listen=1                                \n\
    server=1                                \n\
    maxconnections=16                       \n\
    logtimestamps=1                         \n\
    logips=1                                \n\
                                            \n\
    rpcallowip=127.0.0.1                    \n\
    rpctimeout=15                           \n\
    rpcclienttimeout=15                     \n" > /opt/blockchain/config/litecoin.conf

RUN groupadd litecoin && useradd -r -u 1001 -g litecoin litecoin -m
RUN chown -R litecoin:litecoin /opt/blockchain && chmod -R 700 /opt/blockchain

USER litecoin 

VOLUME ["/opt/blockchain/config", "/opt/blockchain/data"]

# Port, RPC
EXPOSE 9333 9332

CMD ["./litecoind", "-daemon=0"]