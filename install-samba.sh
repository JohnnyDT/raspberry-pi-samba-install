#!bin/bash

# color for console
NC='\033[0m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RED1='\033[0m'
RED2='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'

update_and_upgrade () {
    sudo apt-get update -y --force-yes
    sudo apt-get upgrade
}

install_samba() {
    # https://pimylifeup.com/raspberry-pi-samba/
    
    # install packages that require to setup Samba
    echo -e "${GREEN}--> Installing samba packages ...${NC}" 
    sudo apt-get install --force-yes samba 
    sudo apt-get install --force-yes samba-common-bin

    # create user
# TODO - spytat sa na meno
    echo -e "${GREEN}--> Creating user (pi) ...${NC}"
    sudo smbpasswd -a pi
    
    # create folder which will be shared
# TODO - spytat sa na cestu
    echo -e "${GREEN}--> Creating shared folder (/home/pi/shared) ...${NC}"
    mkdir -p /home/pi/shared     # -p --> subdirectories
    # sudo chmod 1777 /home/pi/shared
    
    # add the following to the bottom of file '/etc/samba/smb.conf'
    echo -e "${GREEN}--> Setting configuration file ...${NC}"
    echo '[rpisambashare]' >> /etc/samba/smb.conf
    echo '   comment = Samba' >> /etc/samba/smb.conf
    echo '   path = /home/pi/shared' >> /etc/samba/smb.conf     # TODO - cestu nedavat na pevno
    echo '   writeable = yes' >> /etc/samba/smb.conf
    echo '   create mask = 0777' >> /etc/samba/smb.conf
    echo '   directory mask = 0777' >> /etc/samba/smb.conf
    echo '   public = no' >> /etc/samba/smb.conf

    # restar samba service
    echo -e "${GREEN}--> Restarting samba service ...${NC}"
    sudo systemctl restart smbd
}

update_and_upgrade
install_samba