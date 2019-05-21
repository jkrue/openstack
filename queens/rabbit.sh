#!/usr/bin/env bash

service rabbit-sever start
rabbitmqctl add_user openstack 123
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
