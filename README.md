# Install Samba server on Raspberry Pi.


![Raspberry Pi and Samba](/images/rpi-samba.jpg)

Install script for Raspberry Pi OS.  
Jednoduchy script pre instalaciu Samba serveru na Raspberry Pi.

### INSTALL
```
wget https://raw.githubusercontent.com/JohnnyDT/raspberry-pi-samba-install/main/install-samba.sh
sh install-samba.sh
```
---
### TO-DO
- [x] Update & upgrade
- [x] Farebny vypis kazdeho prikazu
- [ ] Vybranie mena
- [ ] Vybranie zdielanej zlozky
- [ ] Potvrdenie okna vyriesit

---
### CONFIG-FILE (SAMBA)

```
/etc/samba/smb.conf
```

```
[RPI-share]      
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