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

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/system'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# This resource is used to reset the switch after an image download
# Example :
#	cnos_resetSwitch 'reset' do
#		file     'switch.yml'
#	end

action :create do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename) 
  switch = Connect.new(param)
  System.reset_switch(switch)
  Chef::Log.info "\n\n>>>Reset Switch " + switch.getIp + ' in progress<<<'
end
