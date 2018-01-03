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
# Recipe   : imgDownload
# Config files stored in chef-repo/cookbooks/cnos/files

#transfer Config files for switches to client
cookbook_file '/home/chef/switch.yml' do
        source 'switch.yml'
        action :create
end

#Download Image from TFTP server
cnos_downloadImage 'image' do
	file     'switch.yml'
	protocol 'tftp'
	serverip '192.168.1.1'
	srcfile  'G8296-CNOS-10.4.2.0.img'	
	imgtype  'all'
	vrf_name 'management'
end

#Reset the switch
cnos_resetSwitch 'reset' do
	file     'switch.yml'
end
