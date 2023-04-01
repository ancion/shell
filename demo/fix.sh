#!/usr/bin/sh


# ftp fix 
if [ ! -f /etc/vsftpd.conf ]; then 
  touch /etc/vsftpd.conf
fi
echo "ftpd_banner=Authorized users only. All activity may be monitored and reported." >> /etc/vsftpd.conf

if [ ! -d /etc/pure-ftpd/ ]; then 
  mkdir -p /etc/pure-ftpd/ 
  touch /etc/pure-ftpd/pure-ftpd.conf
fi
if [ ! -f /etc/pure-ftpd/pure-ftpd.conf ]; then 
  touch /etc/pure-ftpd/pure-ftpd.conf
fi
echo "FortunesFile      /usr/share/fortune/zippy" >> /etc/pure-ftpd/pure-ftpd.conf

if [ ! -d /usr/share/fortune/ ]; then 
  mkdir -p /usr/share/fortune/
  touch /usr/share/fortune/zippy
fi
if [ ! -f /usr/share/fortune/zippy ]; then 
  touch /usr/share/fortune/zippy
fi

echo "Authorized users only. All activity may be monitored and reported." >>  /usr/share/fortune/zippy

cat /etc/vsftpd.conf
cat /etc/pure-ftpd/pure-ftpd.conf
cat /usr/share/fortune/zippy



