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

property :vlan, Integer, name_property: true
property :vlan_name, String
property :admin_state, String
property :file, String
property :type, String

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/vlan'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# This resource are used to create vlan, update and delete vlan
# Example - cnos_vlan '21' do
#		file 'switch.yml'
#		vlan 21
#		vlan_name 'vlan21'
#		admin_state 'up'
#		type 'create'
#	    end
action :create do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  if type == 'create'
    params = { 'vlan_name' => vlan_name,
               'vlan_id' => vlan,
               'admin_state' => admin_state }
    Vlan.create_vlan(switch, params)
  end
  if type == 'update'
    params = { 'vlan_name' => vlan_name,
               'vlan_id' => vlan,
               'admin_state' => admin_state }
    Vlan.update_vlan(switch, params)
  end
end

# delete vlan
action :delete do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  Vlan.delete_vlan(switch, vlan)
end
