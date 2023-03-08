#!/bin/bash
# SYNOPSIS
#       Automate Raspberry Pi Backups
# DESCRIPTION
#       Below you can set the default values if no command line args are sent.
#       The script will name the backup files {$HOSTNAME}.{YYYYmmdd}.img
#       When the script deletes backups older then the specified retention
#       it will only delete files with it's own $HOSTNAME.
#       Usage: system_backup.sh {path} {days of retention}
# NOTES
#   File Name           : System_Backup.sh
#   Version             : 0.1
#   Original Author     : Kristofer Källsbo 2017 www.hackviking.com
#   Updated Author      : BJ Beier - https://github.com/bjbeier/Linux-Base-Scripts

# Declare vars and set standard values
backup_path=/mnt/backups
retention_days=3

# Check that we are root!
if [[ ! $(whoami) =~ "root" ]]; then
echo ""
echo "**********************************"
echo "*** This needs to run as root! ***"
echo "**********************************"
echo ""
exit
fi

# Check to see if we got command line args
if [ -n "$1" ]; then
   backup_path=$1
fi

if [ -n "$2" ]; then
   retention_days=$2
fi

# Create trigger to force file system consistency check if image is restored
touch /boot/forcefsck

# Perform backup
dd if=/dev/mmcblk0 of="$backup_path"/"$HOSTNAME"."$(date +%Y%m%d)".img bs=1M

# Remove fsck trigger
rm /boot/forcefsck

# Delete old backups
find "$backup_path"/"$HOSTNAME".*.img -mtime +"$retention_days" -type f -delete