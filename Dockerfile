FROM debian:stretch-slim

ENV BITCOIN_VER 0.17.0

RUN set -x && \
	DEPS="curl" && \
	apt-get update && \
	apt-get -y install ${DEPS} && \
	curl -OL https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VER}/bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz &&\
	tar zxvf bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz && \
	ln -sf /bitcoin-${BITCOIN_VER} /bitcoin && \
	ln -sf /bitcoin/bin/bitcoin-cli /bitcoin-cli && \
	apt-get purge -y --autoremove ${DEPS} && \
	rm -rf /var/lib/apt/lists/*


COPY bitcoin.conf /root/.bitcoin/bitcoin.conf

# rpc
EXPOSE 18444/tcp
# p2p
EXPOSE 18443/tcp

ENTRYPOINT ["/bitcoin/bin/bitcoind", "-printtoconsole"]
