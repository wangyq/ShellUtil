#!/bin/sh

# == for archlinux ==¬
#sudo pacman -S openvswitch
#sudo modeprobe openvswitch  (important!!)

#sudo mkdir -p /etc/openvswitch¬
#sudo ovsdb-tool create /etc/openvswitch/conf.db¬
#sudo ovsdb-server --remote=punix:/run/openvswitch/db.sock \¬
#                 --remote=db:Open_vSwitch,Open_vSwitch,manager_options \¬
#                 --pidfile --detach¬
#sudo ovs-vsctl --db=punix:/run/openvswitch/db.sock  --no-wait init¬
#sudo ovs-vsctl   --no-wait init¬
¬
# == end of archlinux ==¬


sudo mkdir -p /usr/local/etc/openvswitch 
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db /usr/share/openvswitch/vswitch.ovsschema 

sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
                 --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
                 --private-key=db:Open_vSwitch,SSL,private_key \
                 --certificate=db:Open_vSwitch,SSL,certificate \
                 --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
                 --pidfile --detach

sudo ovs-vsctl --no-wait init

#sudo ovs-vswitchd --pidfile --detach 
sudo ovs-vswitchd --pidfile --detach --log-file

#ovs-vsctl list-br 
#ovs-vsctl add-br br0
#ovs-vsctl add-port br0 eth0
#ovs-vsctl add-port br0 vif1.0
