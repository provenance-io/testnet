# pio-testnet-1

<!--
There are external scripts that depend on the files in here; moving or deleting
them would break those scripts, and we don't want to do that.

The files in this directory and the gentx directory should never be changed.
This README.md file is an exception.

The files in `config` subdirectories should not be moved or deleted either.
New version subdirectories can be added to the `config` dir though.
-->

The first public testnet using the 0.40 SDK base Provenance Blockchain is focused on streamlining the process for building the public test network configuration and early beta testing of three of the 4 main Provenance modules (name, attribute, and marker).

- **Explorer** - [explorer.test.provenance.io](https://explorer.test.provenance.io)
- **Faucet** - [faucet.test.provenance.io](https://faucet.test.provenance.io)
- **Seed Nodes** - `c8818d411225372c66cccecc88dcc581ff7f2c03@104.198.181.197:26656,2105e36647e7007bfa7fdea8d45eb3b4d6a69f36@34.75.213.5:26656,08cf5b5fa2b80bf86a6370aec4c4473a0084195b@34.83.1.25:26656`
- **Upgrades** - [https://explorer.test.provenance.io/network/upgrades](https://explorer.test.provenance.io/network/upgrades)

This directory contains files and info related to the `pio-testnet-1` blockchain.

Usage notes:

- If you download a `packed-conf.json' file, you should NOT download the `.toml` config files, and vice versa.
- When downloading a `config.toml` (or `packed-conf.json`) file, you should change the `moniker` value to your own.
- In the `client.toml` (or `packed-conf.json`), you should use your own node's url for the `node` value. If you don't yet have your own node, you can use `https://rpc.test.provenance.io:443`.

## Contents

Most of the files directly in this directory pertain to genesis.
Config files for more recent versions can be found in the `config` directory.

- README.md - This file.
- extra-args.txt - Extra agruments that one might want to include with `provenanced start`.
- genesis-version.txt - The version of `provenanced` used at genesis.
- genesis.json - The genesis file.
- config.toml - A basic `config.toml` file from genesis.
- node-config.toml - A `config.toml` used for a node at genesis.
- node-app.toml - An `app.toml` config file used for a node at genesis.
- config - A directory containing recommended config files at versions other than genesis.

