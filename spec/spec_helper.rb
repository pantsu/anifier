# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require_relative '../lib/api/release'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Bundler.require(:api)
Dir[Rails.root.join('lib/api/grammar/**/*.treetop')].each do |grammar|
  Treetop.load grammar.gsub(/\.treetop$/, '')
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include Devise::TestHelpers,    type: :controller
  config.include Devise::TestHelpers,    type: :helper
  config.include Warden::Test::Helpers,  type: :request
  config.include ApplicationHelper,      type: :helper
  config.include ApplicationHelper,      type: :request
  config.include ThinkingSphinxMatchers, type: :model
  config.include FactoryGirl::Syntax::Methods

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
