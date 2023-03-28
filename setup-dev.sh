#!/bin/sh
echo "\n----|Installing Docker...\n"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh --dry-run

echo "\n----|Installing dependencies...\n"

sudo apt-get -y install build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev

echo "\n----|Installing Bitcoin Core...\n"
sudo add-apt-repository -y ppa:luke-jr/bitcoincore
sudo apt-get update
sudo apt-get -y install bitcoin-qt bitcoin-tx bitcoind 

CONFIG_BTCD=$(cat <<EOF
rpcuser=btc
rpcpassword=abc
rpcallowip=127.0.0.1
regtest=1
server=1
[regtest]
rpcport=8332
EOF
)
printf "$CONFIG_BTCD" > ~/.bitcoin/bitcoin.conf

bitcoind --daemon

./tc -r -u btc -p abc -a -e 127.0.0.1:8332 -m 0x2699ff693FA45234595b6a1CaB6650c849380893:1000000000000000000