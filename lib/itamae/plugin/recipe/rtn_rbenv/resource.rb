# encoding: utf-8

RBENV_DEFAULT_PROFILE_PATH = '/etc/profile.d/rbenv.sh'

# install rbenv and ruby_build
# @param name [String] install directory
# @param user [String] install user name
# @param profile_path [String] bash_profile path
define :rbenv_install, user: nil, profile_path: RBENV_DEFAULT_PROFILE_PATH do
  params = self.params

  git "#{params[:name]}" do
    repository 'https://github.com/rbenv/rbenv.git'
    user params[:user] if params[:user]
  end

  git "#{params[:name]}/plugins/ruby_build" do
    repository 'https://github.com/rbenv/ruby-build.git'
    user params[:user] if params[:user]
  end

  setting = <<"EOS"
export RBENV_ROOT=#{params[:name]}
export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"
eval "$(rbenv init -)"
EOS

  execute 'add rbenv settings' do
    command "echo '#{setting}' >> #{params[:profile_path]}"
    user params[:user] if params[:user]
    not_if "test `touch #{params[:profile_path]} && cat #{params[:profile_path]} | grep 'rbenv' -c` != 0"
  end
end

# install ruby with rbenv
# @param name [String] ruby version
# @param user [String] install user name
# @param profile_path [String] bash_profile path
define :ruby_install, user: nil, profile_path: RBENV_DEFAULT_PROFILE_PATH do
  params = self.params

  execute "ruby install #{params[:name]}" do
    command ". #{params[:profile_path]} && rbenv install #{params[:name]}"
    user params[:user] if params[:user]
    not_if "test `. #{params[:profile_path]} && rbenv versions  | grep '#{params[:name]}' -c` != 0"
  end
end

# install rubygems with rbenv
# @param name [String] gem name
# @param version [String] gem version
# @param ruby_version [String] use ruby version
# @param user [String] install user name
# @param profile_path [String] bash_profile path
define :gem_install, version: nil, ruby_version: nil, force: nil, user: nil, profile_path: RBENV_DEFAULT_PROFILE_PATH do
  params = self.params

  execute "gem install #{params[:name]}" do
    command ". #{params[:profile_path]} && rbenv shell #{params[:ruby_version]} && gem install #{params[:name]} #{params[:version] ? "-v #{params[:version]}" : ''} #{params[:force] ? '--force' : ''}"
    user params[:user] if params[:user]
  end
end
