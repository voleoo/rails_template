# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'sidekiq/testing'
Sidekiq::Testing.inline!
require 'simplecov'

require 'capybara/rspec'
Capybara.default_driver = :selenium
# Capybara.javascript_driver = :poltergeist

SimpleCov.start do
  groups = %w[controllers models helpers services workers decorators]
  groups.each { |name| add_group name.capitalize, "/app/#{name}" }

  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/test/'
  add_filter '/.bundle/'
end

require File.expand_path('../config/environment', __dir__)
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'
ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    Sidekiq::Worker.clear_all
  end

  config.include Capybara::DSL
  config.include Rails.application.routes.url_helpers
  config.include Devise::TestHelpers, type: :controller
  config.include Requests::JsonHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
end
