require "pry"
require "test/unit"
require "test/unit/rr"
require "test/unit/notify" unless ENV['CI']
require "fluent/test"
require 'fluent/test/helpers'
require "fluent/plugin/out_sql_enhanced"
require "fluent/plugin/in_sql_enhanced"

load "fixtures/schema.rb"
