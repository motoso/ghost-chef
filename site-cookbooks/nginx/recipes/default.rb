#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# enable platform default firewall
# @see https://supermarket.chef.io/cookbooks/firewall#knife
firewall 'default' do
  action :install
end

# open standard http port to tcp traffic only; insert as first rule
firewall_rule 'http' do
  port     80
  protocol :tcp
  position 1
  command   :allow
end

package "nginx" do
  action :install
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable]
end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :start, 'service[nginx]'
  notifies :reload, 'service[nginx]'
end

template "/tmp/template_test.txt" do
  source "template-test.txt.erb"
  mode 0644
end
