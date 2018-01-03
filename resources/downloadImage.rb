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
property :protocol, String
property :serverip, String
property :srcfile, String
property :imgtype, String
property :username, String
property :passwd, String
property :vrf_name, String
property :file, String

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/system'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# The resources downloads image from the TFTP server using tftp or sftp
# Waits for the image to be downloaded and resets the switch
# Example - cnos_downloadImage 'image' do
#        	file     '<config file>'
#        	protocol 'tftp'
#        	serverip '<IP ADDRESS>'
#        	srcfile  '<IMG>'
#        	imgtype  'all'
#        	vrf_name 'management'
#	    end

action :create do
  filename = "#{ENV['HOME']}/" + file 
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  if protocol == 'sftp'
    params = { 'protocol' => protocol,
               'serverip' => serverip,
               'srcfile' => srcfile,
               'imgtype' => imgtype,
               'username' => username,
               'passwd' => passwd,
               'vrf_name' => vrf_name }
    System.download_boot_img(switch, params)
    sleeptime = 100
    puts '\n'
    loop do
      resp = System.get_transfer_status(switch, 'download', 'image')
      if resp['status'] == 'successful' || resp['status'] == 'failed'
        break
      else
        Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
      end
      sleep sleeptime
      sleeptime = 10 if sleeptime > 11
    end
    if resp['status'] == 'successful'
      Chef::Log.info 'Transfer status >> ' + resp['status']
      params = { 'boot software' => 'standby' }
      System.put_startup_sw(switch, params)
    else
      Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end

  end

  if protocol == 'tftp'
    params = { 'protocol' => protocol,
               'serverip' => serverip,
               'srcfile' => srcfile,
               'imgtype' => imgtype,
               'vrf_name' => vrf_name }
    System.download_boot_img(switch, params)
    sleeptime = 100
    puts '\n'
    loop do
      resp = System.get_transfer_status(switch, 'download', 'image')
      if resp['status'] == 'successful' || resp['status'] == 'failed'
        break
      else
        Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
      end
      sleep sleeptime
      sleeptime /= 2 if sleeptime > 10
    end
    if resp['status'] == 'successful'
      Chef::Log.info 'Transfer status >> ' + resp['status']
      params = {
        'boot software' => 'standby'
      }
      System.put_startup_sw(switch, params)
    else
      Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end

  end
end
