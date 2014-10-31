showdown-sync
=============

This is a little tool that will manually or automatically sync your Pokemon Showdown! teams to a location
of your choosing on the filesystem.

It will either install as a cronjob, or you can run it manually as you see fit.

Right now it only works in Chrome & Windows >= 7, OS X, and Linux.  More to come.

When you run the installer, it'll ask you to type a path (relative to your home folder) to put backup the teams into.

If you want to run the script manually, you'll also need to manually generate the config file.  Here's how:

Create a new text file called `.config.ini` with the following structure (Linux/Mac):
`[DEFAULT]
BackupLocation = /full/path/to/backup/location
LocalStorageLocation = /Users/username/Library/Application Support/Google/Chrome/Default/Local Storage
BrowserType = Chrome`

or on Windows:
`[DEFAULT]
BackupLocation = C:\Path\to\backup\location
LocalStorageLocation = C:/Users/username/AppData/Local/Google/Chrome/User Data/ Default/Local Storage
BrowserType = Chrome`

BUT if you run the installer, it'll magically generate it.

Yes, it directly reads the LocalStorage sqlite database and outputs valid teams, assuming I didn't goof.

Let me know if you run into problems -> open an issue.

# Install
* Clone this repo
* Ensure you have Python 3 (will package it sometime later)
* Either run main.py to sync your teams ad hoc or `install-mac-linux.sh -i`/`install-windows.bat /i` to install it to your crontab (untested atm)
