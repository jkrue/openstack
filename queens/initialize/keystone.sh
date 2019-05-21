#!/bin/bash

echo "--- configure and start keystone"

# populate keystone database as keystone user
su -s /bin/sh -c "keystone-manage db_sync" keystone

# initialize fernet key repositories
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

# Bootstrap the identity servive
keystone-manage bootstrap --bootstrap-password 123 \
 --bootstrap-admin-url http://controller:5000/v3/ \
 --bootstrap-internal-url http://controller:5000/v3/ \
 --bootstrap-public-url http://controller:5000/v3/ \
 --bootstrap-region-id RegionOne

# Configure apache

cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
echo "ServerName controller" > /etc/apache2/apache2.conf
cat /etc/apache2/apache2.conf.orig >> /etc/apache2/apache2.conf

# Start apache2
service apache2 start

# Source adminc credentials
source /admin.rc

# Create Service project
openstack project create --domain default --description "Service Project" service

# Create user role
openstack role create user