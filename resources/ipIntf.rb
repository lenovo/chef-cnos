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
property :ip_addr, String
property :if_name, String
property :bridge_port, String, default: 'yes'
property :mtu, Integer, default: 1500
property :vrf_name, String
property :admin_state, String
property :ip_prefix_len, Integer

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/ip_intf'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# The resource configures the IP interface for the switch
# Example - cnos_ipIntf '1' do
#		file '<config file>'
#		if_name '<Interface>'
#		bridge_port 'yes/no'
#		mtu '1500'
#		ip_addr '0.0.0.0'
#		ip_prefix_len 0
#		vrf_name 'default'
#		admin_state 'up'
#	    end

action :create do
  filename = "#{ENV['HOME']}/" + file 
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  params = { 'ip_addr' => ip_addr,
             'if_name' => if_name,
             'bridge_port' => bridge_port,
             'mtu' => mtu,
             'vrf_name' => vrf_name,
             'admin_state' => admin_state,
             'ip_prefix_len' => ip_prefix_len }
  resp = Ipintf.update_ip_prop_intf(switch, if_name, params)
  puts resp
end
