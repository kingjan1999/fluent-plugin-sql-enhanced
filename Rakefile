
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.test_files = FileList['test/*/*.rb']
  test.verbose = true
end

task :default => [:build]

namespace :db do
  desc 'Create test DB'
  task :create do
    sh 'psql -d template1 -c "CREATE DATABASE fluentd_test;"'
  end
end
