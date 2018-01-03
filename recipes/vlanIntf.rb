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
# Recipe   : vlan_intf
# Config files stored in chef-repo/cookbooks/cnos/files

#Config vlan for interface on switch
cnos_vlanIntf 'Ethernet1/1' do
	file 'switch.yml'
	interface 'Ethernet1/1'
	bridgeport_mode 'trunk'
	pvid 1
	vlans [20,21]
end


cnos_vlanIntf 'Ethernet1/2' do
	file 'switch.yml'
	interface 'Ethernet1/2'
	bridgeport_mode 'trunk'
	pvid 1
	vlans [20,21]
end
