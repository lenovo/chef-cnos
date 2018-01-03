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
# Recipe   : ip_intf
# Config files stored in chef-repo/cookbooks/cnos/files

#Configure IP interface on switch
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
