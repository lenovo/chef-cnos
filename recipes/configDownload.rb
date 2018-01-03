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
# Recipe   : configDownload
# Config files stored in chef-repo/cookbooks/cnos/files


#Download Config as running config from TFTP server
cnos_swConfig 'config' do
	file 'switch.yml'
	type 'download'
	protocol 'tftp'
	serverip '192.168.1.1'
	srcfile 'switch.conf'
	dstfile 'running_config'
	vrf_name 'management'
end

