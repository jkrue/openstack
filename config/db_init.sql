CREATE DATABASE IF NOT EXISTS keystone CHARACTER SET = 'utf8';
CREATE DATABASE IF NOT EXISTS glance CHARACTER SET = 'utf8';
CREATE DATABASE IF NOT EXISTS nova CHARACTER SET = 'utf8';
CREATE DATABASE IF NOT EXISTS nova_api CHARACTER SET = 'utf8';
CREATE DATABASE IF NOT EXISTS nova_cell0 CHARACTER SET = 'utf8';
CREATE DATABASE IF NOT EXISTS neutron CHARACTER SET = 'utf8';
CREATE DATABASE IF NOT EXISTS cinder CHARACTER SET = 'utf8';

GRANT ALL PRIVILEGES ON *.* TO 'os'@'localhost' IDENTIFIED BY '123';