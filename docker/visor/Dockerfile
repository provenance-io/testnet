# Pull cosmovisor binary
FROM provenanceio/cosmovisor as visor

# Build the actual provenance image
FROM debian:buster-slim
ARG CHAIN_ID

# Check for mandatory build arguments
RUN : "${CHAIN_ID:?Build argument needs to be set and non-empty.}"
ENV CHAIN_ID=$CHAIN_ID

RUN apt-get update && \
    apt-get install -y unzip ca-certificates jq libleveldb-dev wget && \
    ln -s /usr/lib/x86_64-linux-gnu/libleveldb.so.1d /usr/lib/x86_64-linux-gnu/libleveldb.so.1

ENV PIO_HOME=/home/provenance \
    DAEMON_NAME=provenanced \
    DAEMON_HOME=/home/provenance \
    DAEMON_ALLOW_DOWNLOAD_BINARIES=true \
    DAEMON_RESTART_AFTER_UPGRADE=true \
    LD_LIBRARY_PATH=/home/provenance/cosmovisor/current/bin

ADD $CHAIN_ID/genesis-version.txt /$CHAIN_ID/genesis-version.txt

RUN GENESIS_VERSION="$(cat /$CHAIN_ID/genesis-version.txt)" && \
    PIO_URL="https://github.com/provenance-io/provenance/releases/download/${GENESIS_VERSION}" && \
    PIO_ZIP="provenance-linux-amd64-${GENESIS_VERSION}.zip" && \
    echo "Fetching $PIO_URL/$PIO_ZIP" && \
    mkdir -p "${CHAIN_ID}/genesis/" && \
    wget "$PIO_URL/$PIO_ZIP" && \
    unzip "${PIO_ZIP}" -d "${CHAIN_ID}/genesis/"

COPY --from=visor /usr/bin/cosmovisor /usr/bin/cosmovisor

ADD $CHAIN_ID /$CHAIN_ID/
ADD docker/visor/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c", "/usr/bin/cosmovisor start $(cat /$CHAIN_ID/extra-args.txt)"]
