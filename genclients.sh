#!/bin/bash

# Desc: Generates wireguard private and public key
# Usage: ./genclients.sh PEERNAME

umask 077

$PEER = $1

wg genkey | tee $PEER.key | wg pubkey > $PEER.key.pub
