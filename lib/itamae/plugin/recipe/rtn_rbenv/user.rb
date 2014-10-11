# encoding: utf-8
include_recipe 'rtn_rbenv::common'

# load setting
RBENV_USER = (node['rtn_rbenv']['user'] || 'vagrant')
RBENV_USER_HOME = "/home/#{RBENV_USER}"
RBENV_ROOT = "#{RBENV_USER_HOME}/.rbenv"
RBENV_PROFILE_PATH = "#{RBENV_USER_HOME}/.bash_profile"

RBENV_BASH_SETTING = <<"EOS"
export RBENV_ROOT=#{RBENV_ROOT}
export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"
eval "$(rbenv init -)"
EOS

# define
def ruby_install(version)
  execute "ruby install #{version}" do
    command "source #{RBENV_PROFILE_PATH} && rbenv install #{version}"
    user RBENV_USER
    not_if "test `source #{RBENV_PROFILE_PATH} && rbenv versions  | grep '#{version}' -c` != 0"
  end
end

def gem_install(ruby_version, name, options = {})
  execute "gem install #{name}" do
    command "source #{RBENV_PROFILE_PATH} && rbenv shell #{ruby_version} && gem install #{name} #{options[:version] ? "-v #{options[:version]}" : ''} #{options[:force] ? '--force' : ''}"
    user RBENV_USER
  end
end

# install rbenv and ruby_build
git "#{RBENV_ROOT}" do
  repository 'https://github.com/sstephenson/rbenv.git'
  user RBENV_USER
end

git "#{RBENV_ROOT}/plugins/ruby_build" do
  repository 'https://github.com/sstephenson/ruby-build.git'
  user RBENV_USER
end

execute 'add rbenv settings to .bash_profile' do
  command "echo '#{RBENV_BASH_SETTING}' >> #{RBENV_PROFILE_PATH}"
  user RBENV_USER
  not_if "test `touch #{RBENV_PROFILE_PATH} && cat #{RBENV_PROFILE_PATH} | grep 'rbenv' -c` != 0"
end

# install Ruby and Gems
(node['rtn_rbenv']['versions'] || {}).each do |ruby_version, gems|
  ruby_install ruby_version
  gems.each do |gem|
    if gem.kind_of?(Hash)
      gem_install ruby_version, gem['name'], :version => gem['version'], :force => gem['force']
    else
      gem_install ruby_version, gem
    end
  end
end

# set global
if node['rtn_rbenv']['global']
  execute "rbenv global #{node['rtn_rbenv']['global']}" do
    command "source #{RBENV_PROFILE_PATH} && rbenv global #{node['rtn_rbenv']['global']}"
    user RBENV_USER
  end
end
