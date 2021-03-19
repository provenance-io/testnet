#!/usr/bin/env bash

if [ ! -f "${PIO_HOME}/config/genesis.json" ]; then
    mkdir -p "${PIO_HOME}/config"
    cp "/${CHAIN_ID}/genesis.json" "${PIO_HOME}/config/genesis.json"
    cp "/${CHAIN_ID}/config.toml" "${PIO_HOME}/config/config.toml"
fi

if [ ! -d "${PIO_HOME}/cosmovisor/genesis" ]; then
    mkdir -p "${PIO_HOME}/cosmovisor/genesis"
    cp -R "/${CHAIN_ID}/genesis/bin" "${PIO_HOME}/cosmovisor/genesis/"
fi

if [ ! -d "${PIO_HOME}/data" ]; then
    mkdir "${PIO_HOME}/data"
fi

exec "$@"
