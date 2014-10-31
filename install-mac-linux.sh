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
#	-interactive install - sync location 10/27/14 bjs
#	-fix help function calling 10/20/14 bjs
#	-improve help and usage information 10/14/14 bjs
#
##################################################################################################
OPTIND=1
VERSION=2

tmpfile=/tmp/crontab.old
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

mainfile="$SCRIPTPATH/main.py"
configfile="$SCRIPTPATH/.config.ini"
platform=`uname -s`

function install_to_crontab()
{

	echo "I'm going to install this to the crontab.  It'll run once an hour, on the hour."
	read -p "Press [Enter] to continue, else Control+c to stop and not change anything."

	crontab -l > $tmpfile
	echo 0 * * * * $mainfile

	crontab $tmpfile
	rm $tmpfile
}

function write_config()
{
    if [ ! -f $configfile ]
    then
        echo "[DEFAULT]" >>$configfile
        echo "BackupLocation = ${HOME}/${backup_location}" >>$configfile
        echo "LocalStorageLocation = $local_storage" >>$configfile
        echo "BrowserType = $browser_type" >>$configfile
    fi

    install_to_crontab
}

function install_mac
{
    read -r -p "Which folder would you like to backup to? [~/] " backup_location
    cookie_location="${HOME}/Library/Application Support/Google/Chrome/Default/Local Storage"

    if [ -d "$cookie_location" ]
    then
        read -r -p "Would you like to use cookies from Chrome? [Y/n] " response
        case $response in
            [nN][oO]|[nN])
                :
                ;;
            *)
                local_storage=$cookie_location
                browser_type="Chrome"
                write_config
                ;;
        esac

    else
        echo "Support for other browsers coming soon!"

    fi
#    else
#        read -r -p "Would you like to use cookies from Firefox? [Y/n] " response
#        case $response in
#            [nN][oO]|[nN])
#                :
#                ;;
#            *)
#                local_storage=

    write_config
}

function install_linux
{
    read -r -p "Which folder would you like to backup to? [~/] " backup_location

    cookie_location="${HOME}/.config/google-chrome/Default/Cookies"
    if [ -d  $cookie_location ]
    then
        read -r -p "Would you like to use cookies from Chrome? [Y/n] " response
        case $response in
            [nN][oO]|[nN])
                :
                ;;
            *)
                local_storage=$cookie_location
                browser_type="Chrome"
                write_config
                ;;
        esac

    else
        echo "Support for other browsers coming soon!"
    fi

    write_config
}
function install()
{
    if [ $platform == "Darwin" ]
    then
        install_mac
    else
        install_linux
    fi
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

function help_me()
{
	echo "You're hopeless."
	echo "-i Installs program to crontab to run hourly"
	echo "-u Uninstalls program from crontab"
	usage
}

function usage()
{
	echo "usage: `basename $0` options (-i) (-u) -h for help"

}

if ( ! getopts "iuvh" opt); then
	usage
	exit $E_OPTERROR;
fi

while getopts "iuvh" opt; do
	case "$opt" in
		i) install
			exit 0
			;;
		u) uninstall
			exit 0
			;;
		v) echo $VERSION
			exit 0
			;;
		h) help_me
			exit 0
			;;
		*) usage
			exit 0
			;;
	esac
done
