#!/usr/bin/env bash

if [ ! -f "${PIO_HOME}/config/genesis.json" ]; then
    mkdir -p "${PIO_HOME}/config"
    cp "/${CHAIN_ID}/genesis.json" "${PIO_HOME}/config/genesis.json"
    cp "/${CHAIN_ID}/node-config.toml" "${PIO_HOME}/config/config.toml"
fi

if [ ! -d "${PIO_HOME}/data" ]; then
    mkdir "${PIO_HOME}/data"
fi

exec "$@"
