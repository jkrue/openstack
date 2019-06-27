#!/usr/bin/env bash

# start & prepare database
echo "--- start & prepare database"
service mysql start
mysql < /db_init.sql


# start & prepare rabbit
echo "--- start & prepare rabbitmq"
service rabbitmq-server start
rabbitmqctl add_user openstack 123
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

# start memcached
echo "--- start & prepare memcached"
service memcached start

bash /initialize/keystone.sh
bash /initialize/glance.sh
bash /initialize/nova.sh
bash /initialize/neutron.sh
bash /initialize/cinder.sh










