#!/bin/bash

chronyd

if [ ! -f /var/lib/samba/private/sam.ldb ]
then
    if [[ -n $REALM && -n $DOMAIN && -n $ADMINPASS && -n $DNSFORWARDER ]]
    then
        echo Setting up Samba Domain Controller...
        samba-tool domain provision --use-rfc2307 --domain=$DOMAIN --realm=$REALM --adminpass=$ADMINPASS
        cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
        sed -i "s/dns forwarder = .*/dns forwarder = $DNSFORWARDER/g" /etc/samba/smb.conf
        cp /etc/samba/smb.conf /var/lib/samba/private
        echo Starting Samba Domain Controller...
        samba -F
    else
        echo Please define REALM, DOMAIN and ADMINPASS environment variable to setup Samba Domain Controller. 
        exit -1
    fi
else
    echo Starting Samba Domain Controller...
    cp /var/lib/samba/private/krb5.conf /etc/krb5.conf
    cp /var/lib/samba/private/smb.conf /etc/samba
    samba -F -d10
fi
