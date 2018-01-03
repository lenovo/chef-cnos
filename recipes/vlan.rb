##
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
# Cookbook : cnos
# Recipe   : vlan
# Config files stored in chef-repo/cookbooks/cnos/files

#VLAN config for switch
cnos_vlan '21' do
	file 'switch.yml'
	vlan 21
	vlan_name 'vlan21'
	admin_state 'up'
	type 'create'
end

cnos_vlan '29' do
	file 'switch.yml'
	vlan 29
	vlan_name 'Vlan29'
	admin_state 'up'
	type 'create'
end

#Delete VLAN
cnos_vlan '21' do
	action :delete
	file 'switch.yml'
	vlan 21
end
