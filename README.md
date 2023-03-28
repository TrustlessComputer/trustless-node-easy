# trustless-node-easy

This is a guide to setting up a trustless node on a VPS. It is intended for people who are not familiar with Linux and want to get a node up and running quickly.

### Requirements:

      A VPS with at least 4 CPUs, 8GB of RAM and 600GB of disk space.

### Guide for mainnet:

    curl -s https://raw.githubusercontent.com/TrustlessComputer/trustless-node-easy/main/setup-mainnet.sh -o setup-trustless.sh
    chmod +x setup-trustless.sh
    sh ./setup-trustless.sh

### Guide for local development:

    curl -s https://raw.githubusercontent.com/TrustlessComputer/trustless-node-easy/main/setup-dev.sh -o setup-trustless.sh
    chmod +x setup-trustless.sh
    sh ./setup-trustless.sh
