#!/bin/bash

echo "--- configure and start neutron"

source /admin.rc

# Create the neutron user and add the admin role
openstack user create --domain default --password 123 neutron
openstack role add --project service --user neutron admin

# Create the neutron service entity
openstack service create --name neutron --description "OpenStack Networking" network

# Create neutron endpoints
openstack endpoint create --region RegionOne network public http://controller:9696
openstack endpoint create --region RegionOne network internal http://controller:9696
openstack endpoint create --region RegionOne network admin http://controller:9696

# the following does not work in a container
# sysctl net.bridge.bridge-nf-call-iptables 1
# sysctl net.bridge.bridge-nf-call-ip6tables 1

#populate database
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

#start neutron service
service neutron-server start
service neutron-linuxbridge start
service neutron-dhcp-agent-start
service neutron-metadata-agent start