#!/usr/local/opt/ruby/bin ruby
# -*- ruby -*-
#
require 'rake/clean'
require 'rake/testtask'

task :default => :test

# RuboCop::RakeTask.new(:lint) do |task|
#   task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
#   task.fail_on_error = false
# end

task :run do
  ruby 'lib/minimax.rb'
end

task :test do
  ruby 'test/minimax_test.rb'
end