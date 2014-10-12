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
import os

storage_location = os.path.expanduser('~') + '/BTSync/PS Teams/'

if __name__ == '__main__':
    c = cookie_reader()

    for team in c.read_teams():
        with open(storage_location + team[0] + ' ' + team[1] + '.txt', 'w+') as f:
            for p in team[2]:
                f.write(p.get_text())
