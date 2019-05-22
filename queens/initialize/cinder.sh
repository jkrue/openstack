#!/bin/bash

echo "--- configure and start cinder"

source /admin.rc

# Create the cidner user and add the admin role
openstack user create --domain default --password 123 cinder
openstack role add --project service --user cinder admin

# Create the cinder service entity
openstack service create --name cinderv3 --description "OpenStack Block Storage" volumev3

# Create cinder endpoints
openstack endpoint create --region RegionOne volumev3 public http://localhost:8776/v3/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 internal http://localhost:8776/v3/%\(project_id\)s
openstack endpoint create --region RegionOne volumev3 admin http://localhost:8776/v3/%\(project_id\)s

#populate database
su -s /bin/sh -c "cinder-manage db sync" cinder
