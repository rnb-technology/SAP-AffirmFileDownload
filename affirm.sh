#!/bin/csh
# Script to download settlement file from Affirm
# Should run via cron as SIDadm user everyday at 3:30am
# Version 1.0
# Created on 03.07.2019 by Ian Hillier
# ------------------------------------
#
# Setup the variables
set affirmloc=/interfaces/PRD/inbound/AFFIRM
#
# Get the file from Affirm
sftp -o IdentityFile=~/.ssh/id_rsa -b /home/prdadm/scripts/affirm-get.sh -oPort=2222 6SKOP021KJOKU1F8@sam.affirm.com
# Get a listing of the file that was downloaded
cd $affirmloc
set oldfilename=`ls Room*.csv`
echo OldFileName: $oldfilename
# Create the SFTP action file
echo cd reports > /home/prdadm/scripts/affirm-del.sh
echo rm $oldfilename >> /home/prdadm/scripts/affirm-del.sh
# Then connect back to Affirm and delete the file we just downloaded
sftp -o IdentityFile=~/.ssh/id_rsa -b /home/prdadm/scripts/affirm-del.sh -oPort=2222 6SKOP021KJOKU1F8@sam.affirm.com
# set variables for new filename
set newfilename=`echo $oldfilename | sed -r 's/.{26}//' | sed 's/_details//g'`
echo NewFileName: $newfilename
# Rename the file for SAP pickup
mv $oldfilename $newfilename
