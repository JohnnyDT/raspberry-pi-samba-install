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
    sudo apt-get dist-upgrade -y
    sudo apt-get autoremove -y
}

install_samba() {
    # https://pimylifeup.com/raspberry-pi-samba/
    
    # install packages that require to setup Samba
    echo "${GREEN}--> Installing samba packages ...${NC}" 
    sudo apt-get install -y --force-yes samba 
    sudo apt-get install -y --force-yes samba-common-bin

    # create user
# TODO - spytat sa na meno
    echo "${GREEN}--> Creating user (pi) ...${NC}"
    sudo smbpasswd -a pi
    
    # create folder which will be shared
# TODO - spytat sa na cestu
    echo "${GREEN}--> Creating shared folder (/home/pi/shared) ...${NC}"
    mkdir -p /home/pi/shared     # -p --> subdirectories
    # sudo chmod 1777 /home/pi/shared
    
    # add the following to the bottom of file '/etc/samba/smb.conf'
    echo "${GREEN}--> Setting configuration file ...${NC}"
    echo "${BLUE}[rpisambashare]${NC}" | sudo tee -a /etc/samba/smb.conf
    echo "${BLUE}   comment = Samba${NC}" | sudo tee -a /etc/samba/smb.conf
    echo "${BLUE}   path = /home/pi/shared${NC}" | sudo tee -a /etc/samba/smb.conf     # TODO - cestu nedavat na pevno
    echo "${BLUE}   writeable = yes${NC}" | sudo tee -a /etc/samba/smb.conf
    echo "${BLUE}   create mask = 0777${NC}" | sudo tee -a /etc/samba/smb.conf
    echo "${BLUE}   directory mask = 0777${NC}" | sudo tee -a /etc/samba/smb.conf
    echo "${BLUE}   public = no${NC}" | sudo tee -a /etc/samba/smb.conf

    # restar samba service
    echo "${GREEN}--> Restarting samba service ...${NC}"
    sudo systemctl restart smbd
}

update_and_upgrade
install_samba