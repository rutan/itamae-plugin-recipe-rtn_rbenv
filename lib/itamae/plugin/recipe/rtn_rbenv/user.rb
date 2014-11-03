# encoding: utf-8
include_recipe './resource.rb'
include_recipe 'rtn_rbenv::common'

# load setting
RBENV_USER = (node['rtn_rbenv']['user'] || 'vagrant')
RBENV_USER_HOME = "/home/#{RBENV_USER}"
RBENV_ROOT = "#{RBENV_USER_HOME}/.rbenv"
RBENV_PROFILE_PATH = "#{RBENV_USER_HOME}/.bash_profile"

# install rbenv and ruby_build
rbenv_install RBENV_ROOT do
  user RBENV_USER
  profile_path RBENV_PROFILE_PATH
end

# install Ruby and Gems
(node['rtn_rbenv']['versions'] || {}).each do |ruby_version, gems|
  ruby_install ruby_version do
    user RBENV_USER
    profile_path RBENV_PROFILE_PATH
  end
  gems.each do |gem|
    if gem.kind_of?(Hash)
      gem_install gem['name'] do
        self.ruby_version ruby_version
        version gem['version'] if gem['version']
        force gem['force'] if gem['force']
        user RBENV_USER
        profile_path RBENV_PROFILE_PATH
      end
    else
      gem_install gem do
        self.ruby_version ruby_version
        user RBENV_USER
        profile_path RBENV_PROFILE_PATH
      end
    end
  end
end

# set global
if node['rtn_rbenv']['global']
  execute "rbenv global #{node['rtn_rbenv']['global']}" do
    command ". #{RBENV_PROFILE_PATH} && rbenv global #{node['rtn_rbenv']['global']}"
    user RBENV_USER
  end
end
