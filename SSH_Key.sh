# SYNOPSIS
#       Generate an SSH Key and copy it to a remote server.
# DESCRIPTION
#       Allows you choose from the following options:
#           1. Generate SSH Key Only
#           2. Copy SSH Key Only
#           3. Generate SSH Key and Copy
# NOTES
#   File Name   : SSH_Key.sh
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

# Choose what to do
echo 'Choose an option:'
echo '1 Generate SSH Key Only'
echo '2 Copy SSH Key Only'
echo '3 Generate SSH Key and Copy'
echo 'Enter 1, 2, or 3'
read choice
if [ $choice = "1" ];
then
    export keypath=~/.ssh/id_rsa
    echo 'Generate SSH Key'
    echo 'Enter the passphrase for your SSH Key:'
    read passphrase
    ssh-keygen -q -t rsa -N $passphrase -f $keypath
    echo 'Your SSH Key has been created and stored in' $keypath
fi
if [ $choice = "2" ];
then
    echo 'Copy SSH Key'
    echo 'Enter username for remote host'
    read username
    echo 'Enter remote host IP'
    read remotehost
    ssh-copy-id $username@$remotehost
fi
if [ $choice = "3" ];
then
    export keypath=~/.ssh/id_rsa
    echo 'Generate SSH Key'
    echo 'Enter the passphrase for your SSH Key:'
    read passphrase
    ssh-keygen -q -t rsa -N $passphrase -f $keypath
    echo 'Your SSH Key has been created and stored in' $keypath
    echo''
    echo 'Copy SSH Key'
    echo 'Enter username for remote host'
    read username
    echo 'Enter remote host IP'
    read remotehost
    ssh-copy-id $username@$remotehost
fi