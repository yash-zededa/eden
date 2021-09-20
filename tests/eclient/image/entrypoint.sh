#!/bin/bash

# configurable with envs
if [ -z "$AVAHI_HOST_NAME" ]; then AVAHI_HOST_NAME=ubuntu-http-server; fi
if [ -z "$AVAHI_DOMAIN_NAME" ]; then AVAHI_DOMAIN_NAME=local; fi

sed -i "s/^#host-name=.*/host-name=$AVAHI_HOST_NAME/" /etc/avahi/avahi-daemon.conf
sed -i "s/^host-name=.*/host-name=$AVAHI_HOST_NAME/" /etc/avahi/avahi-daemon.conf
sed -i "s/^#domain-name=.*/domain-name=$AVAHI_DOMAIN_NAME/" /etc/avahi/avahi-daemon.conf
sed -i "s/^domain-name=.*/domain-name=$AVAHI_DOMAIN_NAME/" /etc/avahi/avahi-daemon.conf
sed -i 's/^publish-workstation=no/publish-workstation=yes/' /etc/avahi/avahi-daemon.conf
sed -i 's/^use-ipv6=yes/use-ipv6=no/' /etc/avahi/avahi-daemon.conf

service dbus start
service avahi-daemon start
service nginx start

mkdir -p /run/sshd
/usr/sbin/sshd -D
