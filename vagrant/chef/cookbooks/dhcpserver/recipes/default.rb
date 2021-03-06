# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.

package 'isc-dhcp-server' do
  action :install
end

node.default['dhcpserver']['subnets'] = [
  {'subnet' => '192.168.50.0', 'range' => []},
  {'subnet' => '192.168.51.0', 'range' => ['192.168.51.150', '192.168.51.250']}
]

template '/etc/dhcp/dhcpd.conf' do
  source 'dhcpd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[isc-dhcp-server]'
end

cookbook_file '/etc/default/isc-dhcp-server' do
  source 'etc_default_isc-dhcp-server'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[isc-dhcp-server]'
end


service 'isc-dhcp-server' do
    action [:enable, :start]
end
