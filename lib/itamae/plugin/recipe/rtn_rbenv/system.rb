# encoding: utf-8
include_recipe './resource.rb'
include_recipe 'rtn_rbenv::common'

# load setting
RBENV_ROOT = '/usr/local/rbenv'
RBENV_PROFILE_PATH = '/etc/profile.d/rbenv.sh'

# install rbenv and ruby_build
rbenv_install RBENV_ROOT do
  profile_path RBENV_PROFILE_PATH
end

# install Ruby and Gems
(node['rtn_rbenv']['versions'] || {}).each do |ruby_version, gems|
  ruby_install ruby_version do
    profile_path RBENV_PROFILE_PATH
  end
  gems.each do |gem|
    if gem.kind_of?(Hash)
      gem_install gem['name'] do
        self.ruby_version ruby_version
        version gem['version'] if gem['version']
        force gem['force'] if gem['force']
        profile_path RBENV_PROFILE_PATH
      end
    else
      gem_install gem do
        self.ruby_version ruby_version
        profile_path RBENV_PROFILE_PATH
      end
    end
  end
end

# set global
if node['rtn_rbenv']['global']
  execute "rbenv global #{node['rtn_rbenv']['global']}" do
    command ". #{RBENV_PROFILE_PATH} && rbenv global #{node['rtn_rbenv']['global']}"
  end
end
