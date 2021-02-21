# Install Samba server on Raspberry Pi.


![Raspberry Pi and Samba](/images/rpi-samba.jpg)

Install script for Raspberry Pi OS.  
Jednoduchy script pre instalaciu Samba serveru na Raspberry Pi.

### DOWNLOAD
```
wget https://raw.githubusercontent.com/JohnnyDT/raspberry-pi-samba-install/main/install-samba.sh
```

### INSTALL
Function "update_and_upgrade()" of system is off by default.
```
wget https://raw.githubusercontent.com/JohnnyDT/raspberry-pi-samba-install/main/install-samba.sh
sh install-samba.sh
```
### UNINSTALL
```
sudo apt-get purge samba samba-common
sudo apt-get autoremove samba samba-common
```

### SETTING ON WINDOWS
```
\\raspberrypi\rpi-share
```

![Samba - Windows](/images/WindowsExplorer.png)

![Samba - Windows](/images/MapNetworkDrive.png)

![Samba - Windows](/images/UserCredentials.png)

---
### CONFIG-FILE (SAMBA)

```
/etc/samba/smb.conf
```

```
[rpi-share]      
    comment = Samba
    path = /home/pi/shared  
    writeable = yes
    create mask = 0777
    directory mask = 0777
    public = no
```

---

### SAMBA STATUS
```
systemctl status smbd
```
OR
```
service smbd status 
```

---
### TO-DO
- [x] Update & upgrade
- [x] Farebny vypis kazdeho prikazu
- [ ] Vybranie mena
- [ ] Vybranie zdielanej zlozky
- [ ] Potvrdenie okna vyriesit