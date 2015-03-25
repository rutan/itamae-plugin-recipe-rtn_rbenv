# encoding: utf-8
execute 'apt-get update -y' if node[:platform] =~ /ubuntu/
include_recipe 'rtn_rbenv::user'

