#!/bin/bash
# SYNOPSIS
#       Install default apps and run default configurations. Must be run as ROOT.
# DESCRIPTION
#       Install the follwing applications:
#           1. nfs-common - Needed for backing up to NAS
#           2. cifs-utils - Needed to connecto to Windows shares
#       Complete the following configurations:
#           1. Create mount directory for System_Backup.sh
#           2. Update fstab with backup mount point
#           3. Mount new mount point
#           4. Schedule daily backup to run at 1AM
# NOTES
#   File Name   : Fresh_Instal.sh
#   Version     : 0.1
#   Author      : BJ Beier - https://github.com/bjbeier/Linux-Base-Scripts

# Check that we are root!
if [[ ! $(whoami) =~ "root" ]]; then
echo ""
echo "**********************************"
echo "*** This needs to run as root! ***"
echo "**********************************"
echo ""
exit
fi

#
# App Installations
#

# Install nfs-common
apt install nfs-common -y

# Install cifs-utils
apt install cifs-utils -y

#
# Configurations
#

# Create /mnt/Backups
mkdir /mnt/Backups

# Update fstab with network location for NAS
echo '192.168.4.140:/volume1/Backups /mnt/backups nfs x-systemd.automount 0 0' >> /etc/fstab

# Mount new location
mount -a

# Write out current crontab
crontab -l > mycron

# Echo new cron into cron file
echo "0 1 * * * /mnt/backups/system_backup.sh" >> mycron

# Install new cron file
crontab mycron
rm mycron