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
property :dstfile, String
property :username, String
property :passwd, String
property :vrf_name, String
property :type, String
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

# The resources downloads/uploads switch config from the TFTP server using tftp or sftp
# Example - cnos_swConfig 'config' do
#		file '<config file>'
#		type 'download/upload'
#		protocol 'tftp/sftp'
#		serverip '192.168.1.1'
#		srcfile '<switch.conf>'
#		dstfile 'running_config/startup_config'
#		vrf_name 'management'
#	    end

action :create do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  if type == 'download'
    if protocol == 'tftp'
      params = { 'protocol' => protocol,
                 'serverip' => serverip,
                 'srcfile' => srcfile,
                 'dstfile' => dstfile,
                 'vrf_name' => vrf_name }
      System.download_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'download', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    else
      params = {
        'protocol' => protocol,
        'serverip' => serverip,
        'srcfile' => srcfile,
        'dstfile' => dstfile,
        'username' => username,
        'passwd' => passwd,
        'vrf_name' => vrf_name }
      System.download_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'upload', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end
  end

  if type == 'upload'
    if protocol == 'tftp'
      params = { 'protocol' => protocol,
                 'serverip' => serverip,
                 'srcfile' => srcfile,
                 'dstfile' => dstfile,
                 'vrf_name' => vrf_name }
      System.upload_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'upload', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    else
      params = { 'protocol' => protocol,
                  'serverip' => serverip,
                  'srcfile' => srcfile,
                  'dstfile' => dstfile,
                  'username' => username,
                  'passwd' => passwd,
                  'vrf_name' => vrf_name }
      System.upload_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'upload', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end
  end
end
