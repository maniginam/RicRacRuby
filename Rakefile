#!/usr/local/opt/ruby/bin ruby
# frozen_string_literal: true

# -*- ruby -*-
#
require 'rake/clean'
require 'rake/testtask'

task default: :run

# RuboCop::RakeTask.new(:lint) do |task|
#   task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
#   task.fail_on_error = false
# end

task :run do
  ruby 'lib/main.rb'
end

task :test do
  ruby 'test/minimax_test.rb'
  ruby 'test/board_test.rb'
  ruby 'test/game_master_test.rb'
  ruby 'test/ai_player_test.rb'
  ruby 'test/terminal_gui_test.rb'
  ruby 'test/setup_test.rb'
end
