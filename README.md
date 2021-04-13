# Provenance Network Testnets
Testnet configurations for public [Provenance.io](https://provenance.io) network

## Active Test Networks

| Name          | Genesis Version | Current Version | Wasm Verison   | Genesis Finalized    | Network Start        |
|---------------|-----------------|-----------------|----------------|----------------------|----------------------|
| testnet-alpha | 0.1.2           | 1.0.0           | v0.16.0-alpha1 | 27-01-2021 17:00:00Z | 29-01-2021 18:40:00Z |

| Name          | Genesis Version | Software Version | Wasm Verison   | Genesis Finalized    | Network Start        |
|---------------|-----------------|------------------|----------------|----------------------|----------------------|
| pio-testnet-1 | 0.2.0           | 1.0.0            | v0.16.0-alpha1 | 09-03-2021 18:45:00Z | 09-03-2021 19:00:00Z |

## Upcoming Public Test Networks

| Name          | Software Version | Wasm Verison | Genesis Finalized    | Network Start        |
|---------------|------------------|--------------|----------------------|----------------------|
| pio-testnet-2 | tbd              | tbd.         | 10-02-2021 17:00:00Z | 11-02-2021 17:00:00Z |


### testnet-alpha

The first public testnet using the 0.40 SDK base Provenance Blockchain is focused on streamlining the process for building the public test network configuration and early beta testing of three of the 4 main Provenance modules (name, attribute, and marker).

- **Explorer** - [explorer.test.provenance.io](https://explorer.test.provenance.io)
- **Faucet** - [faucet.test.provenance.io](https://faucet.test.provenance.io)
- **Persistant Peer** - 93b5812b4059295c02e545fb769e74d950512b3c@35.243.142.236:26656
- **Seed Node** - b8f84a4d5b35bc2f82317da784076ab0f23725ce@pio-testnet-1.seed-0.test.provenance.io:26656

### pio-testnet-1

The first public testnet using the 0.40 SDK base Provenance Blockchain is focused on streamlining the process for building the public test network configuration and early beta testing of three of the 4 main Provenance modules (name, attribute, and marker).

- **Explorer** - [explorer.test.provenance.io](https://explorer.test.provenance.io)
- **Faucet** - [faucet.test.provenance.io](https://faucet.test.provenance.io)
- **Persistant Peer** - 26240dd8c5f78c3c54196613b9c04d2d750a534e@35.232.121.26:26656,8fcbbdba4088a604d6c083dd6be19e070adc1d93@35.194.76.143:26656,1f159852f00292803d8c937d953cb3da68a25624@34.75.172.89:26656,7970256f3f8879e0152bb26e977d2139890cb59d@34.82.40.187:26656
- **Seed Node** - 2de841ce706e9b8cdff9af4f137e52a4de0a85b2@104.196.26.176:26656,add1d50d00c8ff79a6f7b9873cc0d9d20622614e@34.71.242.51:26656

### pio-testnet-2

The second testnet is planned as a software release/in place upgrade of the testnet and is expected to launch three weeks after the first testnet.

## Development Networks

Development networks can be started by cloning the github.com/provenance-io/provenance repository and running the `make localnet-start` target.
