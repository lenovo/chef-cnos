#
## Copyright (c) 2017, Lenovo. All rights reserved.
##
## This program and the accompanying materials are licensed and made available
## under the terms and conditions of the 3-clause BSD License that accompanies
## this distribution.
##
## The full text of the license may be found at
##
## https://opensource.org/licenses/BSD-3-Clause
##
## THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
## WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
##

property :file, String
property :interface, String
property :bridgeport_mode, String
property :pvid, Integer, default: 1
property :vlans, Array

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/vlan_intf'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# Defaults to the first action
default_action :create

# This resource is used to configure IP interface on the switch
# Example -  cnos_ipIntf '1' do
#		file 'switch.yml'
#		if_name 'Ethernet1/1'
#		bridge_port 'yes'
#		mtu '1500'
#		ip_addr '0.0.0.0'
#		ip_prefix_len 0
#		vrf_name 'default'
#		admin_state 'up'
#           end

action :create do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename) 
  switch = Connect.new(param)
  params = { 'if_name' => interface,
             'bridgeport_mode' => bridgeport_mode,
             'pvid' => pvid,
             'vlans' => vlans }
  resp = VlanIntf.update_vlan_intf(switch, interface, params)
  Chef::Log.info "\n VLAN Interface Info  "
  puts resp
end
