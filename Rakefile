require 'rake'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    targets << File.basename(dir)
  end
  platforms = %w[sl6 ubuntu1404]

  task :all     => targets
  task :default => :all

  targets.each do |target|
    platforms.each do |platform|
      desc "Run serverspec tests to #{target} in #{platform}"
      RSpec::Core::RakeTask.new(target.to_sym) do |t|
        ENV['TARGET_HOST'] = "#{platform}_#{target}"
        t.pattern = "spec/#{target}/*_spec.rb"
      end
    end
  end
end
