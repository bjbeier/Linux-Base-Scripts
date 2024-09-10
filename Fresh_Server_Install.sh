# SYNOPSIS
#       Install default apps and run default configurations. Must be run as ROOT.
# DESCRIPTION
#       Install the follwing applications:
#           1. nfs-common - Needed for backing up to NAS
#           2. cifs-utils - Needed to connecto to Windows shares
#           3. Webmin - Web GUI for server management
#           4. Docker - Container Platform
#           5. Docker Compose v2 - Define and build containers for Docker
#       Complete the following configurations:
#           1. Create mount directory for System_Backup.sh
#           2. Update fstab with backup mount point
#           3. Mount new mount point
#           4. Create ssh key directory
# NOTES
#   File Name   : Fresh_Server_Instal.sh
#   Version     : 0.4
#   Author      : BJ Beier - https://github.com/bjbeier/Linux-Base-Scripts

# Set Shell
#!/bin/bash

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

# Update repositories
apt update

# Install nfs-common
apt install nfs-common -y

# Install cifs-utils
apt install cifs-utils -y

# Install Webmin
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sh setup-repos.sh -y
apt install webmin -y
rm -f setup-repos.sh

# Install Docker
apt install docker.io -y

# Install Docker Compose v2
apt install docker-compose-v2 -y

#
# Configurations
#

# Create /mnt/Backups
mkdir /mnt/Backups

# Update fstab with network location for NAS
echo '192.168.4.140:/volume1/Backups /mnt/Backups nfs x-systemd.automount 0 0' >> /etc/fstab

# Mount new location
mount -a

# Create ssh key directory
mkdir ~/.ssh/