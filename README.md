# Openstack API in a single container
This repositories offer a full Openstack API (KeyStone,Nova, Neutron, Glance and Cinder) in a single container.


# Build
Building the container is straightforward :

``` 
docker build -t openstack:<version> -f Dockerfile.<version> .
```

where version is a supported Openstack version (queens or rocky).
Depending on your network bandwidth and your compute power  building the container takes a while.

# Usage
Once build, the container can be started  :

```
docker run -p 5000:5000 -p 9292:9292 \
           -p 8774:8774 -p 8776:8776 \
           -p 8778:8778 -p 9696:9696 \
           -d openstack:<version>
```

On the host  you can access the API  using  Openstack cmdline tools. 

```
source admin.rc
openstack endpoint list
+----------------------------------+-----------+--------------+--------------+---------+-----------+-----------------------------------------+
| ID                               | Region    | Service Name | Service Type | Enabled | Interface | URL                                     |
+----------------------------------+-----------+--------------+--------------+---------+-----------+-----------------------------------------+
| 436e195d88ae4072a44a775ad7e9a5f4 | RegionOne | neutron      | network      | True    | internal  | http://localhost:9696                   |
| 52d0792c778149efb71974e586b82ea1 | RegionOne | nova         | compute      | True    | internal  | http://localhost:8774/v2.1              |
| 5b2bd5cd7b5248e6a415d299192a511a | RegionOne | placement    | placement    | True    | admin     | http://localhost:8778                   |
| 5ebf9c243fb24334a2c187c3a25db8be | RegionOne | keystone     | identity     | True    | internal  | http://localhost:5000/v3/               |
| 625a4503f2ea44fbbf0b9554b9a15093 | RegionOne | keystone     | identity     | True    | public    | http://localhost:5000/v3/               |
| 63654f8ca1044563ab674dc2da1bb36e | RegionOne | cinderv3     | volumev3     | True    | admin     | http://localhost:8776/v3/%(project_id)s |
| 87401f979e6247e6ab7caa6bf4691492 | RegionOne | placement    | placement    | True    | internal  | http://localhost:8778                   |
| 8c50873be67747f685d92f38f584fcce | RegionOne | neutron      | network      | True    | public    | http://localhost:9696                   |
| 9aa05ae56a2641efa0adf60fb291707f | RegionOne | placement    | placement    | True    | public    | http://localhost:8778                   |
| a6806c23e5174508bf030a55f1d31802 | RegionOne | cinderv3     | volumev3     | True    | public    | http://localhost:8776/v3/%(project_id)s |
| a83f42577c6740ab87f2a3e65797ba19 | RegionOne | neutron      | network      | True    | admin     | http://localhost:9696                   |
| aee592bb72a549d580b2c237268b0e63 | RegionOne | nova         | compute      | True    | admin     | http://localhost:8774/v2.1              |
| b1d352b82bab44d1bf5e7b5c298acf5d | RegionOne | glance       | image        | True    | admin     | http://localhost:9292                   |
| b8592680c1b348289a545baa22c45ba0 | RegionOne | cinderv3     | volumev3     | True    | internal  | http://localhost:8776/v3/%(project_id)s |
| c988996d91954629b6d946be004f16c8 | RegionOne | glance       | image        | True    | internal  | http://localhost:9292                   |
| d871bdb3bcd840fc8cb696ebe6a3824d | RegionOne | nova         | compute      | True    | public    | http://localhost:8774/v2.1              |
| ec78fbcf4dc7411381fd47a18e02b04d | RegionOne | keystone     | identity     | True    | admin     | http://localhost:5000/v3/               |
| f719c391def84004a21057c50be953e7 | RegionOne | glance       | image        | True    | public    | http://localhost:9292                   |
+----------------------------------+-----------+--------------+--------------+---------+-----------+-----------------------------------------+
```


