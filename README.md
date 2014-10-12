showdown-sync
=============

This is a little tool that will manually or automatically sync your Pokemon Showdown! teams to a location
of your choosing on the filesystem.

It will either install as a cronjob, or you can run it manually as you see fit.

Right now it only works in Chrome & Windows >= 7, OS X, and Linux.  More to come.

You have to manually edit the sync location in main.py right now, that'll be changed soon.

Yes, it directly reads the LocalStorage sqlite database and outputs valid teams, assuming I didn't goof.

Let me know if you run into problems -> open an issue.

= Install = 
* Clone this repo
* Ensure you have Python 3 (will package it sometime later)
* Either run main.py to sync your teams ad hoc or install.py -i to install it to your crontab (untested atm)
