#! /usr/bin/bash

# ------------------------------------------------------------------
#    Title : Script to Setup Static IP
#    Author : thumuvikram@gmail.com
#    Script version : 1.0
#    Description : This script will setup static IP for VM
# ------------------------------------------------------------------

        echo "Enter below values of VM as per Plan"
        read -p 'Enter New Hostname to configure for VM: ' VM_hostname
        read -p 'Enter a Static IP to configure for VM: ' VM_staticip
        read -p 'Enter Gateway IP Address: ' gateway
        echo "we are about setup static ip for VM ....."
        sleep 10
        hostnamectl set-hostname $VM_hostname
        cp /etc/hosts /etc/hosts.bak
        echo "$VM_staticip $VM_hostname" >> /etc/hosts
        rm -f /etc/sysconfig/network-scripts/ifcfg-enp0s3.bak
        cp /etc/sysconfig/network-scripts/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3.bak
        echo -e "IPADDR=$VM_staticip \nDNS1=$gateway \nDNS2=8.8.8.8 \nGATEWAY=$gateway" >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
        sed -i 's/dhcp/static/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
        sed -i 's/ONBOOT=no/ONBOOT=yes/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
        echo "We have successfully configured VM on static IP"
        sleep 5
        echo "VM will reboot to impact changes and reconnect using new static IP"
        sleep 5
        shutdown -r
