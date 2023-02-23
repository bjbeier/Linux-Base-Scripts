# SYNOPSIS  
#    Update bash script
# DESCRIPTION  
#    Basic script to store in a standard location to allow running updates easily. The file will complete the following tasks:
#    1. Update repositories
#    2. Run application and system updates
#    3. Remove un-needed applications
#    Make sure to make the file executable using 'run chmod u+x'. Then you can run the script using the command './Updates.sh'
# NOTES  
#    File Name   : Update.sh  
#    Version     : 0.1
#    Author      : BJ Beier - https://github.com/bjbeier/Linux-Base-Scripts

# Update all repositories
sudo apt update

# Install updates that are available. The -y switch allows automatically installing the updates. If you prefer to review the updates first, remove -y.
sudo apt upgrade -y

# Remove any un-needed applications. The -y switch allows automatically installing the updates. If you prefer to review the updates first, remove -y.
sudo apt autoremove -y
