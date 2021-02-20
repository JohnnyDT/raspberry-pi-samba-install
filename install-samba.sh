#!bin/bash

# color for console
NC='\033[0m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RED1='\033[0m'
RED2='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'

update_and_upgrade() {
    # Update and upgrade 
    echo "${RED}--> Update and upgrade ...${NC}" 
    sudo apt-get -qq update -y --force-yes
    sudo apt-get -qq dist-upgrade -y
    sudo apt-get -qq autoremove -y
    echo "${RED}--> Done. ${NC}" 
}

install_samba() {
    
    # install packages that require to setup Samba
    echo "${GREEN}--> Installing samba packages ...${NC}" 
    sudo apt-get -qq install -y --force-yes samba
    sudo apt-get -qq install -y --force-yes samba-common-bin

    # create user
# TODO - spytat sa na meno
    echo "${GREEN}--> Creating user (pi) ...${NC}"
    echo "${GREEN}Set your password: ${NC}"
    sudo smbpasswd -a pi
    
    # create folder which will be shared
# TODO - spytat sa na cestu
    echo "${GREEN}--> Creating shared folder (/home/pi/shared) ...${NC}"
    mkdir -p /home/pi/shared     # -p --> subdirectories
    # sudo chmod 1777 /home/pi/shared
    
    # add the following to the bottom of file '/etc/samba/smb.conf'
    echo "${GREEN}--> Setting configuration file ...${NC}"
    echo "${GREEN}----------------------------------${NC}"
    echo "[rpi-share]" | sudo tee -a /etc/samba/smb.conf
    echo "   comment = Samba" | sudo tee -a /etc/samba/smb.conf
    echo "   path = /home/pi/shared" | sudo tee -a /etc/samba/smb.conf     # TODO - cestu nedavat na pevno
    echo "   writeable = yes" | sudo tee -a /etc/samba/smb.conf
    echo "   create mask = 0777" | sudo tee -a /etc/samba/smb.conf
    echo "   directory mask = 0777" | sudo tee -a /etc/samba/smb.conf
    echo "   public = no" | sudo tee -a /etc/samba/smb.conf
    echo "${GREEN}----------------------------------${NC}"

    # restart samba service
    echo "${GREEN}--> Restarting samba service ...${NC}"
    sudo systemctl restart smbd
}

# update_and_upgrade
#
install_samba