#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = %w[ lib ]
  t.warning = true
  t.verbose = true
  t.test_files = FileList['test/*_test.rb']
end

task default: :test
