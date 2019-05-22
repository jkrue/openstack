from ubuntu:18.04

# install & configure timezone
ENV TZ 'Europe/Berlin'
RUN echo $TZ > /etc/timezone && \
  apt-get update && apt-get install -y tzdata && \
  rm /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean


# install openstack client
RUN apt-get update && apt-get install -y python-openstackclient

# install & configure rabbitmq
RUN apt-get update && apt-get install -y rabbitmq-server

# install & configure memcache
RUN apt-get update && apt-get install -y memcached python-memcache

# install & configure mysql
RUN apt-get update && apt-get install -y mariadb-server
COPY db_init.sql /db_init.sql

# install & configure keystone
RUN apt-get update && apt-get install -y keystone apache2 libapache2-mod-wsgi
COPY keystone.conf /etc/keystone/keystone.conf
RUN chown keystone:root /etc/keystone/keystone.conf

COPY admin.rc /admin.rc

# install & configure glance
RUN apt-get update && apt-get install -y glance
COPY glance-api.conf /etc/glance/glance-api.conf
COPY glance-registry.conf /etc/glance/glance-registry.conf
RUN chown root:glance /etc/glance/glance-api.conf /etc/glance/glance-registry.conf

# install & configure nova
RUN apt-get update && apt-get install -y nova-api nova-conductor nova-consoleauth nova-novncproxy nova-scheduler nova-placement-api
COPY nova.conf /etc/nova/nova.conf
RUN chown root:nova /etc/nova/nova.conf

# install & configure neutron
RUN apt-get update & apt-get install -y neutron-server neutron-plugin-ml2 neutron-linuxbridge-agent neutron-dhcp-agent neutron-metadata-agent
COPY neutron.conf /etc/neutron/neutron.conf
COPY dhcp_agent.ini /etc/neutron/dhcp_agent.ini
COPY ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
COPY linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini
RUN chown root:neutron /etc/neutron/neutron.conf
RUN chown root:neutron /etc/neutron/dhcp_agent.ini
RUN chown root:neutron /etc/neutron/plugins/ml2/ml2_conf.ini
RUN chown root:neutron /etc/neutron/plugins/ml2/linuxbridge_agent.ini

# install & configure cinder
RUN apt-get update & apt-get install -y cinder-api cinder-scheduler
COPY cinder.conf /etc/cinder/cinder.conf
RUN chown root:cinder /etc/cinder/cinder.conf

# copy initialize script
COPY initialize /initialize

# dashboard/horizon
EXPOSE 80
# keystone
EXPOSE 5000
# glance
EXPOSE 9292
# nova
EXPOSE 8774
# cinder
EXPOSE 8776
# placement
EXPOSE 8778
# neutron
EXPOSE 9696


# CMD
# CMD bash /initialize.sh

RUN initialize/initialize.sh

COPY start.sh /start.sh

CMD ["/bin/bash","/start.sh"]






