#!/usr/bin/bash

# Desc:	Uploads file to your minecraft server's plugin directory
# Usage:	./plugin_upload /path/to/plugin.jar

USER=user
SERVER_IP=192.168.1.1
SERVER_PLUGINDIR=/home/user/mc-server/plugins/
PORT=22
JARFILE=$1

ARG="scp -P$PORT $JARFILE $USER@$SERVER_IP:$SERVER_PLUGINDIR"

echo $ARG
$($ARG)
