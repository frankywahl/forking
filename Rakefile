# encoding: utf-8

require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn 'Run `gem install bundler` to install Bundler.'
  exit(-1)
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems.'
  exit e.status_code
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new do |tasks|
  tasks.console.command = 'pry'
end

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.title = 'Forking'
end
task doc: :rdoc

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task test: :spec
task default: [:rubocop, :spec]

task rebuild: [:build, :install]
