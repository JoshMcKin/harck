$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'harck'
require 'rspec'
require 'bundler/setup'
require 'active_record'

ENV['RAILS_ENV'] ||= 'test'

TEST_ROOT=File.join(File.dirname(__FILE__), '../')

Dir[File.join(TEST_ROOT, "spec/support/**/*.rb")].each {|f| require f }

TestDB.connect
TestMigrations.down
TestMigrations.up

RSpec.configure do |config|
end