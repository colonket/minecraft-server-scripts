#!/usr/bin/env bash

# Desc:		Creates a screen session for your Minecraft server
# Author:	colonket
# Date:		2022-03-19

# pushd and popd are used to perform commands in the right directory
pushd() {
        command pushd "$@" > /dev/null
}

popd() {
        command popd "$@" > /dev/null
}

# Define the java binary you would like to use
#JBIN="/opt/jdk-17/bin/java"
JBIN="java"

# Define where your Minecraft server directory is
MCDIR="/path/to/serverdir/"

# Define what arguments to use for your Minecraft server
JVMARGS="-Xmx8G"

# Define the filename of your server's jar file
MCJAR="server.jar"

# Define the screen name to use for resuming, i.e. `screen -r mc`
MCSCREEN="mc"

# Constructs statement to use for running your Minecraft server
MCARG="$JBIN ${JVMARGS} -jar ${MCDIR}/${MCJAR} nogui"

# Change directory to Minecraft server directory
pushd $MCDIR

# Start screen session
command="screen -dmS $MCSCREEN $MCARG"
if $command ; then
        echo "Starting screen '${MCSCREEN}' from ${MCDIR} -> '${MCARG}'"
else
        echo 'ERROR - Failed to start Minecraft server screen session'
fi

# Return to directory you ran start.sh from
popd

