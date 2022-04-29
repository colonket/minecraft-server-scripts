#!/bin/bash

# Name:		sussy-checker.sh
# Author:	colonket
# Version:	0.2
# Date:		2022-04-28
# Desc:		Returns the minecraft server console log entries matching
#			the usernames of players not in a whitelist.
#			This script was written for a public minecraft server
#			in response to suspicious player behavior

# FILES NEEDED:
#	- .log files (gunzip your .log.gz files first!)
#	- whitelist.json
#	- usercache.json

allowed_path="../whitelist.json"
usercache_path="../usercache.json"
ALLOWED=($(jq -r '.[] | .name' $allowed_path))
PLAYERS=($(jq -r '.[] | .name' $usercache_path))
SUSSY=()

gunzip_logs () {
	if [ -f "*.gz" ]; then
		gunzip *.gz
	fi
}

array_contains () {
	# Usage: array_contains LIST_TO_CHECK player_to_be_found
	# Returns True if player is found in LIST_TO_CHECK
	local array="$1[@]"
	local seeking=$2
	local in=1
	for i in "${!array}"; do
		if [[ $i == "$seeking" ]]; then
			in=0
			break
		fi
	done
	return $in
}


build_sussy_list() {
	# Adds any player not in the whitelist to
	# the SUSSY array
	for player in "${PLAYERS[@]}"; do
		if array_contains ALLOWED $player; then
			#echo "$player is allowed"
			continue
		else
			echo "$player is not allowed"
			SUSSY+=($player)
		fi
	done
}

print_sussy_logs() {
	# Prints the lines in your log files
	# matching players in the SUSSY array
	for sus in "${SUSSY[@]}"; do
		grep -rie "$sus" *.log
	done
}

print_failed_login_usernames() {
	grep -re 'Username' *.log | cut -d ' ' -f6
}

gunzip_logs
build_sussy_list
print_sussy_logs
#print_failed_login_usernames
