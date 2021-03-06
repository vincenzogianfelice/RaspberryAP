#!/bin/bash

if [ "$EUID" -ne "0" ]; then
   echo "Solo l'amministratore può eseguire questa operazione!"
   echo ""
   exit 1
fi

if [ -f /etc/init.d/raspberryap ]; then
   echo "Aggiorno il servizio"
   cp raspberryap /etc/init.d/
   chmod +x /etc/init.d/raspberryap
   chown root:root /etc/init.d/raspberryap
   systemctl daemon-reload
   exit 0
fi

echo "Sto abilitando lo script come servizio"

cp raspberryap /etc/init.d/
chmod +x /etc/init.d/raspberryap
chown root:root /etc/init.d/raspberryap
update-rc.d raspberryap defaults
systemctl enable raspberryap
systemctl disable hostapd
systemctl disable hostapd.service
systemctl disable dnsmasq
systemctl disable dnsmasq.service

exit 0
