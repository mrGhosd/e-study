#
# Cookbook Name:: estudy
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'create postgres vagrant user' do
  code = <<-EOH
    psql -U postgres -c "select * from pg_user where usename='vagrant'" | grep vagrant
  EOH
  command "sudo su postgres -c 'psql -c \"CREATE USER vagrant WITH PASSWORD '\"'\"'vagrant'\"'\"' SUPERUSER;\"'"
  not_if code
end

%w(git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl).each do |pkg|
    package pkg
  end

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch' do
  type :package # type of install
  version "1.7.2"
  action :install # could be :remove as well
end
elasticsearch_configure 'elasticsearch'

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

include_recipe 'ruby_build'
rbenv_script "bundle_install" do
  rbenv_version "2.3.0"
  user          "vagrant"
  cwd           "/home/vagrant/estudy"
  code          %{bundle install}
end
