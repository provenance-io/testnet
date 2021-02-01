# Provenance Network Testnets
Testnet configurations for public [Provenance.io](https://provenance.io) network

## Active Test Networks

| Name          | Software Version | Wasm Verison | Genesis Finalized    | Network Start        |
|---------------|------------------|--------------|----------------------|----------------------|
| testnet-alpha | 0.1.2            | 0.12.2       | 27-01-2021 17:00:00Z | 29-01-2021 18:40:00Z |

## Upcoming Public Test Networks

| Name          | Software Version | Wasm Verison | Genesis Finalized    | Network Start        |
|---------------|------------------|--------------|----------------------|----------------------|
| pio-testnet-2 | tbd              | tbd.         | 10-02-2021 17:00:00Z | 11-02-2021 17:00:00Z |


### testnet-alpha

The first public testnet using the 0.40 SDK base Provenance Blockchain is focused on streamlining the process for building the public test network configuraiotn and early beta testing of three of the 4 main Provenance modules (name, attribute, and marker).

- **Explorer** - [explorer.test.provenance.io](https://explorer.test.provenance.io)
- **Faucet** - [faucet.test.provenance.io](https://faucet.test.provenance.io)
- **Persistant Peer** - 93b5812b4059295c02e545fb769e74d950512b3c@35.243.142.236:26656
- **Seed Node** - b8f84a4d5b35bc2f82317da784076ab0f23725ce@pio-testnet-1.seed-0.test.provenance.io:26656

### pio-testnet-2

The second testnet is planned as a software release/in place upgrade of the testnet and is expected to launch three weeks after the first testnet.

## Development Networks

Development networks can be started by cloning the github.com/provenance-io/provenance repository and running the `make localnet-start` target.
