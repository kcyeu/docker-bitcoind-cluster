FROM debian:stretch-slim

ENV BITCOIN_VER 0.17.1
ENV BITCOIN_DIR /bitcoin-0.17.1
ENV PATH ${BITCOIN_DIR}:${PATH}

RUN set -x && \
	DEPS="curl" && \
    BITCOIN_BIN_TGZ=bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz && \
	apt-get update && \
	apt-get -y install ${DEPS} && \
	curl -OL https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VER}/${BITCOIN_BIN_TGZ} &&\
	tar zxvf ${BITCOIN_BIN_TGZ} && \
	ln -sf ${BITCOIN_DIR} /bitcoin && \
    mkdir -p /root/.bitcoin /bitcoind-data && \
	apt-get purge -y --autoremove ${DEPS} && \
    rm -f ${BITCOIN_BIN_TGZ} && \
	rm -rf /var/lib/apt/lists/*


COPY bitcoin.conf /root/.bitcoin/bitcoin.conf

ENTRYPOINT ["/bitcoin/bin/bitcoind", "-printtoconsole", "-conf=/root/.bitcoin/bitcoin.conf", "-datadir=/bitcoind-data"]
