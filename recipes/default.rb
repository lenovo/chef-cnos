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
# Cookbook:: cnos
# Recipe:: default


#Upgrade client machine
execute "update-upgrade" do
  command "apt-get update && apt-get upgrade -y"
  action :run
end

#Install rest-client
chef_gem 'rest-client' do
        action :install
end
require 'rest-client'

#Install LenovoCheflib
chef_gem 'LenovoCheflib' do
	action :install
end
require 'LenovoCheflib'

