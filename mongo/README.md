mongo-sync


Sync Remote and Local MongoDB Databases in Bash. Works with Heroku too!

For all the Rubyists out there, I've converted this in to a Ruby Gem as well.


Usage


Download / Clone the script

git clone https://github.com/sheharyarn/mongo-sync.git
cd mongo-sync




Edit config.yml and insert your configuration details


Use the script like this:

 ./mongo-sync push [options]		# Push DB to Remote
 ./mongo-sync pull [options]		# Pull DB to Local




Options

 -y  # Skip confirmation
 --config alternate-config-file.yml





Notes


mongo-sync requires mongodump and mongorestore binaries to be installed in your system. If you have mongodb installed, then you probably already have them
Pushing/Pulling overwrites the Target DB
It's a good idea to keep your config.yml in .gitignore if you're using it inside some other project


TODO

Add a --no-overwrite flag+feature that doesn't drop the target db before restoring it, and actually tries to sync it
Add a backup command and an --auto-backup feature
Add more options for Local DB in config.yml
