Bridger - Building bridges with Chef
====================================

Does what's described: builds a bridge, using chef

Important attributes
--------------------

* node[:bridger][:interface] = 'eth0' (interface to bridge to)
* node[:bridger][:name] = 'br0' (name of the bridge)
* node[:bridger][:dhcp] = false (dhcp in use on interface)
* node[:bridger][:address] = nil (static address to use) 
* node[:bridger][:netmask] = '255.255.255.0' (netmask in use)
* node[:bridger][:gateway] = nil (gateway to use)

You can add more bridges using:

* node[:bridger][:additionals]

It accepts an array of hashes with the hashes using the same
structure as above to provide bridge information.

Repository
----------

* https://github.com/heavywater/chef-bridger
