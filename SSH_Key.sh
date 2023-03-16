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
Echo 'Choose an option:'
Echo '1 Generate SSH Key Only'
Echo '2 Copy SSH Key Only'
Echo '3 Generate SSH Key and Copy'
Echo 'Enter 1, 2, or 3'
Read choice
If [ $(choice) = "1" ]; then
    export keypath=~/.ssh/id_rsa
    Echo 'Generate SSH Key'
    Echo 'Enter the passphrase for your SSH Key:'
    Read passphrase
    ssh-keygen -q -t rsa -N $passphrase -f $keypath
    Echo 'Your SSH Key has been created and stored in' $keypath
fi
If [ $(choice) = "2" ]; then
    Echo 'Copy SSH Key'
    Echo 'Enter username for remote host'
    Read username
    Echo 'Enter remote host IP'
    Read remotehost
    ssh-copy-id $username@$remotehost
fi
If [ $(choice) = "3" ]; then
    export keypath=~/.ssh/id_rsa
    Echo 'Generate SSH Key'
    Echo 'Enter the passphrase for your SSH Key:'
    Read passphrase
    ssh-keygen -q -t rsa -N $passphrase -f $keypath
    Echo 'Your SSH Key has been created and stored in' $keypath
    Echo''
    Echo 'Copy SSH Key'
    Echo 'Enter username for remote host'
    Read username
    Echo 'Enter remote host IP'
    Read remotehost
    ssh-copy-id $username@$remotehost
fi