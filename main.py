#!/bin/env python3
########################################################################################################################
#
# main.py
#
# Purpose: Take localstorage PS teams and turn them into text for safe storage in Dropbox, etc.
#
# Author: Braxton J. Schafer (bjschafer) [bjs]
#
# Creation date: 10/12/2014
#
# Copyright (c) 2014 Braxton J. Schafer
#
# Changelog:
#
########################################################################################################################
from cookie_reader import cookie_reader
import configparser

CONFIG_FILE_LOCATION = './.config.ini'


def read_config():
    config = configparser.ConfigParser()
    config.read(CONFIG_FILE_LOCATION)

    storage_location = config['DEFAULT']['BackupLocation']
    cookie_location = config['DEFAULT']['LocalStorageLocation']
    browser_type = config['DEFAULT']['BrowserType']

    return storage_location, cookie_location, browser_type

# storage_location = os.path.expanduser('~') + '/BTSync/PS Teams/'

if __name__ == '__main__':
    config = read_config()
    c = cookie_reader(config[1], config[2])

    for team in c.read_teams():
        with open(config[0] + team[0] + ' ' + team[1] + '.txt', 'w+') as f:
            for mon in team[2]:
                f.write(mon.get_text())
