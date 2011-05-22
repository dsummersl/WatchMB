#!/bin/sh

# this script takes a photo and stamps it for you. It expects the imagesnap
# program to be in ~/scripts

################################################################################
# Configuration:

destination=~/Dropbox/Photos/watch

#
################################################################################

currentDirectory=`dirname $0`
wacaw="${currentDirectory}/wacaw"

nowdate=`date +%m%d%y%H%M%S`

# to record a picture snapshot:
# size is like 30k
$wacaw --jpeg --VGA $destination/$nowdate

# to record a 3 second video instead of a picture:
# just a note that the first second appears to be stationary, and the video size is like 5meg
#~/scripts/wacaw --video --duration 3  --VGA $destination/$nowdate

# capture the screen:
/usr/sbin/screencapture -t jpg -x -m t.jpg
# resample down to a max width of 950
sips -s format jpeg --resampleWidth 950 t.jpg --out $destination/$nowdate-screen.jpg

# get public ip address from checkip.dyndns.org
public_ip=`wget -q -O - checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`

# TODO I want it to be a simple HTML page with the IP address and then a link to google maps (more detailed than what I have now)
# get physical address from ip address from melissadata.com
# very approximate. I want someting better.
#wget -q -O - \
#http://www.melissadata.com/Lookups/iplocation.asp?ipaddress=$public_ip | \
#grep "\(\(State or Region\)\|\(Latitude & Longitude\)\|\(IP Address\)\)<\/td>" | \
#sed "s/.*<b>\([^<]*\)<\/b>.*/\1/"

echo $public_ip > $destination/$nowdate-loc.txt
