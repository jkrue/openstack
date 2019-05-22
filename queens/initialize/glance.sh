#!/bin/bash


echo "--- configure and start glance"

source /admin.rc

# Create the glance user and add the admin role
openstack user create --domain default --password "123" glance
openstack role add --project service --user glance admin

# Create the glance service entity
openstack service create --name glance --description "OpenStack Image" image

# Create the Image service API endpoints
openstack endpoint create --region RegionOne image public http://localhost:9292
openstack endpoint create --region RegionOne image internal http://localhost:9292
openstack endpoint create --region RegionOne image admin http://localhost:9292

# populate database
su -s /bin/sh -c "glance-manage db_sync" glance

# start the image services
service glance-registry start
service glance-api start