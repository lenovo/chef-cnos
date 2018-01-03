# Lenovo CNOS Cookbook

## Overview
The cnos cookbook provides a set of recipes and resources for managing Lenovo
switches. The cookbook provides resources to upload images, upload/download
configurations and VLAN provisioning. The recipes use the CNOS Ruby APIs
(Ruby GEM) to communicate with the switch OS and configure them.

## Recipes

Below is the list of recipe instances provided as a part of the CNOS cookbook.

### 1. configUpload
This recipe uploads configuration to the switches.<br /><br />
Example - using attributes

```ruby
cnos_swConfig 'config' do
  file     node['cnos']['file']
  type     'upload'
  protocol node['cnos']['protocol']
  serverip node['cnos']['tftp_server']
  srcfile  'running_config'
  dstfile  node['cnos']['switch_conf']
  vrf_name node['cnos']['vrf_name']
end
```

Example - using values

```ruby
cnos_swConfig 'config' do
  file 'switch.yml'
  type 'upload'
  protocol 'tftp'
  serverip '192.168.1.1'
  srcfile 'running_config'
  dstfile 'switch.conf'
  vrf_name 'management'
end
```

### 2. configDownload

This recipe downloads configuration to the switches. The same configuration
can be edited/modified and uploaded back using the configUpload recipe. <br /><br />

Example - using attributes

```ruby
cnos_swConfig 'config' do
  file     node['cnos']['file']
  type     'download'
  protocol node['cnos']['protocol']
  serverip node['cnos']['tftp_server']
  srcfile  node['cnos']['switch_conf']
  dstfile  'running_config'
  vrf_name node['cnos']['vrf_name']
end
```

Example - using values

```ruby
cnos_swConfig 'config' do
  file 'switch.yml'
  type 'download'
  protocol 'tftp'
  serverip '192.168.1.1'
  srcfile 'switch.conf'
  dstfile 'running_config'
  vrf_name 'management'
end
```

### 3. imgUpload
This recipe upload new OS image to the switch. <br /><br />

Example - using attributes

```ruby
cnos_downloadImage 'image' do
  file     node['cnos']['file']
  protocol node['cnos']['protocol']
  serverip node['cnos']['tftp_server']
  srcfile  node['cnos']['nos_image']
  imgtype  'all'
  vrf_name node['cnos']['vrf_name']
end
```

Example - using values

```ruby
cnos_downloadImage 'image' do
  file     'switch.yml'
  protocol 'tftp'
  serverip '192.168.1.1'
  srcfile  'G8296-CNOS-10.4.2.0.img'
  imgtype  'all'
  vrf_name 'management'
end
```

### 4. vlan
This recipe manages the VLAN (create/update/delete) provisiong on the switch.<br /><br />

Example - using attributes

```ruby
cnos_vlan '21' do
  file        node['cnos']['file']
  vlan        21
  vlan_name   'vlan21'
  admin_state node['cnos']['admin_state']
  type        'create'
end
```

Example - using values

```ruby
cnos_vlan '21' do
  file 'switch.yml'
  vlan 21
  vlan_name 'vlan21'
  admin_state 'up'
  type 'create'
end
```

### 5. vlanIntf

This recipe provides the management of VLAN properties for ethernet and
port-channel interfaces.<br /><br />

Example - using attributes

```ruby
cnos_vlanIntf 'Ethernet1/1' do
  file            node['cnos']['file']
  interface       'Ethernet1/1'
  bridgeport_mode 'trunk'
  pvid            1
  vlans           [20, 21]
end
```

Example - using values

```ruby
cnos_vlanIntf 'Ethernet1/1' do
  file 'switch.yml'
  interface 'Ethernet1/1'
  bridgeport_mode 'trunk'
  pvid 1
  vlans [20,21]
end
```

### 6. ipIntf

This recipe provides the management of IP interfaces.<br /><br />

Example - using attributes

```ruby
cnos_ipIntf '1' do
  file          node['cnos']['file']
  if_name       'Ethernet1/1'
  bridge_port   node['cnos']['bridge_port']
  mtu           node['cnos']['mtu']
  ip_addr       node['cnos']['ip_addr']
  ip_prefix_len node['cnos']['ip_prefix_len']
  vrf_name      node['cnos']['vrf_name']
  admin_state   node['cnos']['admin_state']
end
```

Example - using values

```ruby
cnos_ipIntf '1' do
  file 'switch.yml'
  if_name 'Ethernet1/1'
  bridge_port 'yes'
  mtu '1500'
  ip_addr '0.0.0.0'
  ip_prefix_len 0
  vrf_name 'default'
  admin_state 'up'
end
```

**Note** - All the above recipes require the config file to reside on the client. You can also create one at the workstation and transfer to the client using chef resources in a recipe

## Dependencies
* Chef 13 or later
* Lenovo CNOS 10.4 or later

## Running the cookbook
1. Install chef-client on the node
2. Install Lenovo CNOS Ruby GEM in the same node(or include in default recipe).
3. Create and transfer using recipe switch.yml for each Lenovo device to be configured using the work
   station, see below example file

```yaml
transport : 'http' #http or https
port : '8090' #8090 or 443
ip : 'switch ip address' #Switch IP address
user : '<user>' #Credentials
password : '<password>' #Credentials
```
4. Add required recipe to node run-list
5. Run chef-client on node
6. Upload to the run-list of the chef-server and configure the devices

## Testing
The cookbook was originally tested direclty on a Ubuntu 16.04 VM, set up as client.
In the setup,
1. A config file 'switch.yml' was created on the workstation and transferred to the client using recipe.
2. 'cnos-rbapi' gem was installed using recipe(default.rb)
3. Image download, Switch config and Vlan Config recipes(given as instances above) were tested on the VM and the configurations were verified.

Test tools such as Test kitchen or ChefSpec can also be used to run test recipes on the workstation


## Contributors
* Lenovo DCG Networking, Lenovo

## License
Apache 2.0, See LICENSE file
