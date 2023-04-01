#!/bin/sh

echo "\n----|Stopping Services...\n"

docker compose down

echo "\n----|Stopping Bitcoind...\n"

bitcoin-cli -rpcuser=trustless -rpcpassword=notrespassing stop