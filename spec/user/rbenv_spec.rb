require 'spec_helper'

describe command('. /home/vagrant/.bash_profile; which rbenv') do
  let(:disable_sudo) { true }
  its(:stdout) { should match '/home/vagrant/.rbenv/bin/rbenv' }
end

%w[2.1.4 2.1.3].each do |ruby_version|
  describe command(". /home/vagrant/.bash_profile; rbenv versions | grep '#{ruby_version}'") do
    let(:disable_sudo) { true }
    its(:stdout) { should match /#{Regexp.escape(ruby_version)}/ }
  end
end

describe command(". /home/vagrant/.bash_profile; rbenv shell 2.1.4; gem list | grep 'sinatra'") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /sinatra/ }
end

describe command(". /home/vagrant/.bash_profile; rbenv shell 2.1.3; gem list | grep 'rake'") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /10\.2\.0/ }
end

describe command(". /home/vagrant/.bash_profile; ruby -v") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /2\.1\.4/ }
end

