########################################################################################################################
#
# cookie_reader.py
#
# Purpose: read cookies from the web browser (currently only Chrome supported) and make them into Python objects
#
# Author: Braxton J. Schafer (bjschafer) [bjs]
#
# Creation date: 10/10/2014
#
# Copyright (c) 2014 Braxton J. Schafer
#
# Changelog:
#
########################################################################################################################

import sqlite3 as sqlite
import sys
import os.path
import json
from pokemon import pokemon

class cookie_reader():

    def __init__(self, cookie_location, browser_type):
        self.cookie_location = cookie_location
        self._expand_tilde()
        self.filename = "http_play.pokemonshowdown.com_0.localstorage"


    def _get_cookie_location(self):
        platform = sys.platform

        if (platform == 'darwin'):
            return "~/Library/Application Support/Google/Chrome/Default/Local Storage/"
        elif (platform == 'linux2'):
            return "~/.config/google-chrome/Default/Cookies"
        elif (platform == 'win32' or platform == 'win64'):
            return "~/AppData/Local/Google/Chrome/User Data/ Default/Local Storage/"
        return "Platform not recognized."

    def _expand_tilde(self):
        self.cookie_location = self.cookie_location.replace('~', os.path.expanduser('~'))

    def _read_from_database(self):
        conn = sqlite.connect(self.cookie_location + self.filename)
        conn.text_factory = str
        c = conn.cursor()
        c.execute("""SELECT value FROM ItemTable WHERE key='showdown_teams'""")
        return c.fetchone()

    def _get_json(self):
        raw_json = str(self._read_from_database())
        raw_json = raw_json[3:-3]
        raw_json = raw_json.replace('\\x00', '')

        return json.loads(raw_json)

    def read_teams(self):
        decoded = self._get_json()

        for team in decoded:
            yield (team['name'], team['format'], [pokemon(t) for t in team['team']])





if __name__ == '__main__':
    c = cookie_reader()
    for t in c.read_teams():
        print(t)