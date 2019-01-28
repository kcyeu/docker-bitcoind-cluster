# Dockerized bitcoind cluster with stunnel

This repository allows you run a full bitcoin network. You can run the cluster 
in three modes, mainnet, regtest and testnet by linking `docker-compose.override.yml`
to different files. Communication of JSON-RPC is protected by `stunnel`.


## Requirements

1. To run this you need both `docker` and `docker-compose`. It was tested on a 
clean Ubuntu 16.04 with the docker-ce package from Docker.
2. Create the following bind mounts for data persistence:
  * `/mnt/bitcoin/cluster/1`
  * `/mnt/bitcoin/cluster/2`
  * `/mnt/bitcoin/cluster/3`


## Usage

Link specific docker-compose file to `docker-compose.override.yml`, then simply 
run `docker-compose up` to start all the containers. This will start the 
bitcoin nodes, and expose RPC on all of them. The nodes will run on the 
following ports:

| Node   | P2P port *    | RPC port *    | RPC Username  | RPC Password  |
|--------|---------------|---------------|---------------|---------------|
| master | 18500         | 18400         | bitcoin       | bitcoin       |
| node2  | 18501         | 18401         | bitcoin       | bitcoin       |
| node3  | 18502         | 18402         | bitcoin       | bitcoin       |


## Examples

### Mainnet

```
ln -sf docker-compose.mainnet.yml docker-compose.override.yml
docker-compose up
```

### Testnet

```
ln -sf docker-compose.testnet.yml docker-compose.override.yml
docker-compose up
```


## Default Ports

### Bitcoind node

| Mode    | P2P port | RPC port |
|---------|----------|----------|
| regtest |   18444  |   18443  |
| testnet |   18333  |   18332  |
| mainnet |    8333  |    8332  |

### JSON-RPC over SSL

| Mode    | JSON-RPC over SSL |
|---------|-------------------|
| regtest |            28443  |
| testnet |            28332  |
| mainnet |            18332  |

