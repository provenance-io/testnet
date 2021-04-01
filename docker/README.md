# Quick reference

- **Maintained by**: [The Provenance Devops Team](https://github.com/provenance-io/testnet)
- **Where to file issues**: [Provenance Testnet Issue Tracker](https://github.com/provenance-io/testnet/issues)

# Supported tags and respective `Dockerfile` links:

- [`testnet-beta`](https://raw.githubusercontent.com/provenance-io/testnet/main/docker/node/visor/Dockerfile)
- [`testnet-beta-archive`](https://raw.githubusercontent.com/provenance-io/testnet/main/docker/node/archive/Dockerfile)
- [`pio-testnet-1`](https://raw.githubusercontent.com/provenance-io/testnet/main/docker/node/visor/Dockerfile)
- [`pio-testnet-1-archive`](https://raw.githubusercontent.com/provenance-io/testnet/main/docker/node/archive/Dockerfile)

# Quick reference (cont.)

- **Supported architectures**: [`amd64`]
  - **Why not more?**: Upstream dependencies currently lock us into amd64 (namely libwasm). There are future plans for other archs.
- **Source of this description**: [docs](https://raw.githubusercontent.com/provenance-io/testnet/main/docker/README.md)

# What is this image?

The `provenanceio/node` images are used to quickly bootstrap a genesis node on one of the provenance testnets. They contain the genesis content as well as a subset of peer and seed nodes to bootstrap a connection with.

# How to use this image

In these docs, `${chain-id}` is a placeholder for one of [`testnet-beta`, `pio-testnet-1`].

## Quick start for ${chain-id}

Background

```console
$ docker run --name my-node -d -v $(pwd)/testnet:/home/provenance provenanceio/node:${chain-id}
```

Interactive

```console
$ docker run -it --rm --name my-node -v $(pwd)/testnet:/home/provenance provenanceio/node:${chain-id}
```

- Note: The directory ./testnet will contain all data, configs, and binaries related to this chain id.

## Custom configuration files

If you choose to use a custom config.toml or app.toml configuration file, you can pre-create them. The bootstrap process will not overwrite these existing files.

```console
$ mkdir -p ./testnet/config
$ cp my-custom-config.toml testnet/config/config.toml
$ cp my-custom-app.toml testnet/config/app.toml
```

If you choose to use the default, and tweak that, spin up the docker image with a no-op, and edit the created file.

```console
$ docker run --rm --name my-node -v $(pwd)/testnet:/home/provenance provenanceio/node:${chain-id} true
$ vi testnet/config/config.toml
$ vi testnet/config/app.toml
<edit>
```

## Exposing external ports

- **Common ports**
  - api: `1317`
  - rpc: `26657`
  - grpc: `9090`

```console
$ docker run --name my-node -p 1317:1317 -p 26657:26657 -p 9090:9090 -v $(pwd)/testnet:/home/provenance provenanceio/node:${chain-id}
```
