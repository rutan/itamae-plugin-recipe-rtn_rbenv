require 'spec_helper'

describe command('which rbenv') do
  let(:disable_sudo) { true }
  its(:stdout) { should match '/usr/local/rbenv/bin/rbenv' }
end

%w[2.1.3 2.1.0].each do |ruby_version|
  describe command("source /etc/profile && rbenv versions | grep '#{ruby_version}'") do
    let(:disable_sudo) { true }
    its(:stdout) { should match /#{Regexp.escape(ruby_version)}/ }
  end
end

describe command("source /etc/profile && rbenv shell 2.1.3 && gem list") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /sinatra/ }
end

describe command("source /etc/profile && rbenv shell 2.1.0 && gem list | grep 'rake'") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /10\.2\.0/ }
end

describe command("source /etc/profile && ruby -v") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /2\.1\.0/ }
end
