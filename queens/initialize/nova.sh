#!/bin/bash

# --- nova
echo "--- configure and start nova"

source /admin.rc

# Create the nova user and add the admin role
openstack user create --domain default --password "123" nova
openstack role add --project service --user nova admin

# Create the nova service entity
openstack service create --name nova --description "OpenStack Compute" compute

# Create the nova endpoints
openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1

# Create the nova placement user and  add the admin role
openstack user create --domain default --password "123" placement
openstack role add --project service --user placement admin

# Create the nova placement service entity
openstack service create --name placement --description "Placement API" placement

# Create the nova placement endpoint
openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

# populate the api database
su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova

# start the nova services
service nova-api start
service nova-consoleauth start
service nova-scheduler start
service nova-conductor start
service nova-novncproxy start

