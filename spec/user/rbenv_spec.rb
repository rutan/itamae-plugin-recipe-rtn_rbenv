require 'spec_helper'

describe command('source /home/vagrant/.bash_profile; which rbenv') do
  let(:disable_sudo) { true }
  its(:stdout) { should match '/home/vagrant/.rbenv/bin/rbenv' }
end

%w[2.1.3 2.1.0].each do |ruby_version|
  describe command("source /home/vagrant/.bash_profile; rbenv versions | grep '#{ruby_version}'") do
    let(:disable_sudo) { true }
    its(:stdout) { should match /#{Regexp.escape(ruby_version)}/ }
  end
end

describe command("source /home/vagrant/.bash_profile; rbenv shell 2.1.3; gem list | grep 'sinatra'") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /sinatra/ }
end

describe command("source /home/vagrant/.bash_profile; rbenv shell 2.1.0; gem list | grep 'rake'") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /10\.2\.0/ }
end

describe command("source /home/vagrant/.bash_profile; ruby -v") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /2\.1\.3/ }
end

