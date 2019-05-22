#!/bin/bash

echo "--- start database"
service mysql start


echo "--- start rabbitmq"
service rabbitmq-server start


echo "--- start  memcached"
service memcached start

echo "--- start apache2"
service apache2 start

echo "--- start glance"
service glance-registry start
service glance-api start

echo "--- start nova"
service nova-api start
service nova-consoleauth start
service nova-scheduler start
service nova-conductor start
service nova-novncproxy start

echo "--- start neutron"
service neutron-server start
#service neutron-linuxbridge start
#service neutron-dhcp-agent-start
service neutron-metadata-agent start


echo "-- startup finished"

while true; do sleep 10; done;