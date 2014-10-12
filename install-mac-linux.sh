#!/bin/bash
###################################################################################################
#
# install-mac-linux.sh
# 
# Purpose: Installs the file (from current directory) into crontab to run once an hour. 
#
# Author: Braxton J. Schafer (bjschafer) [bjs]
#
# Creation date: 10/12/2014
#
# Copyright (c) 2014 Braxton J. Schafer
#
# Changelog:
#
##################################################################################################
OPTIND=1
VERSION=1

tmpfile=/tmp/crontab.old
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

mainfile="$SCRIPTPATH/main.py"

while getopts "iuvh" opt; do
	case "$opt" in
		i) install
			exit 0
			;;
		u) uninstall
			exit 0
			;;
		v) echo $version
			exit 0
			;;
		h) help
			exit 0
			;;
		*) usage
			exit 0
			;;
	esac
done

function install()
{
	echo "I'm going to install this to the crontab.  It'll run once an hour, on the hour."
	read -p "Press [Enter] to continue, else Control+c to stop and not change anything."

	crontab -l > $tmpfile
	echo 0 * * * * $mainfile

	crontab $tmpfile
	rm $tmpfile
}

function uninstall()
{
	echo "I'm going to remove this from the crontab.  You can still run it manually."
	read -p "Press [Enter] to continue, else Control+c to stop and not change anything."

	crontab -l > $tmpfile

	sed -i "/0 * * * * $mainfile" $tmpfile
	crontab $tmpfile
	rm $tmpfile
}

function help()
{
	echo "You're hopeless"
}

function usage()
{
	echo "-i to install, -u to uninstall.  Just like magic!"
}