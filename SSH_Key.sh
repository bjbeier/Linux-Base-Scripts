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
if [[ ! $(whoami) =~ "root" ]];
then
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
if [ $choice = '1' ]; # Generate Only
then
    export keypath=~/.ssh/id_rsa
    echo 'Generate SSH Key'
    echo 'Enter the passphrase for your SSH Key:'
    read passphrase
    ssh-keygen -q -t rsa -N $passphrase -f $keypath
    echo 'Your SSH Key has been created and stored in' $keypath
fi
if [ $choice = '2' ]; # Copy Only
then
    echo 'Copy SSH Key'
    echo 'Enter username for remote host'
    read username
    echo 'Enter remote host IP'
    read remotehost
    echo 'Choose host type:'
    echo '1. Linux'
    echo '2. Windows'
    read hosttype
    if [ $hosttype = '1' ]; # Linux
    then
        ssh-copy-id $username@$remotehost
    fi
    if [ $hosttype = '2' ]; # Windows
    then
        # Install Powershell on Linux
            #Update the list of packages
            sudo apt-get update
            # Install pre-requisite packages.
            sudo apt install wget apt-transport-https software-properties-common -y
            # Download the Microsoft repository GPG keys
            wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
            # Register the Microsoft repository GPG keys
            sudo dpkg -i packages-microsoft-prod.deb
            # Update the list of packages after we added packages.microsoft.com
            sudo apt update
            # Install PowerShell
            sudo apt install powershell -y
            # Start PowerShell
            pwsh
        # Write SSH Key to file
        authorizedKey=$(cat "/home/$USER/.ssh/id_rsa.pub")

        # Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
        $remotePowershell= "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '$authorizedKey';icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F"""

        # Connect to your server and run the PowerShell using the $remotePowerShell variable
        ssh $username@$remotehost $remotePowershell

        # Uninstall Powershell
        sudo apt-get remove powershell -y
    fi
fi
if [ $choice = '3' ]; # Generate and Copy
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
    echo 'Choose host type:'
    echo '1. Linux'
    echo '2. Windows'
    read hosttype
    if [ $hosttype = '1'];
    then
        ssh-copy-id $username@$remotehost
    fi
    if [ $hosttype = '2'];
    then
        # Install Powershell on Linux
        #Update the list of packages
        sudo apt-get update
        # Install pre-requisite packages.
        sudo apt-get install -y wget apt-transport-https software-properties-common
        # Download the Microsoft repository GPG keys
        wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
        # Register the Microsoft repository GPG keys
        sudo dpkg -i packages-microsoft-prod.deb
        # Update the list of packages after we added packages.microsoft.com
        sudo apt-get update
        # Install PowerShell
        sudo apt-get install -y powershell
        # Start PowerShell
        pwsh
        # Write SSH Key to file
        authorizedKey=$(cat "/home/$USER/.ssh/id_rsa.pub")

        # Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
        $remotePowershell = "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '$authorizedKey';icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F"""

        # Connect to your server and run the PowerShell using the $remotePowerShell variable
        ssh $username@$remotehost $remotePowershell

        # Uninstall Powershell
        sudo apt-get remove powershell -y
    fi
fi