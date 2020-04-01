# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_factory_bot_rails.rb

inject_into_file 'Gemfile', after: 'group :development, :test do' do
  <<-RUBY.chomp

  gem 'factory_bot_rails'
  RUBY
end

inject_into_file 'spec/rails_helper.rb', after: 'RSpec.configure do |config|' do
  <<-RUBY
  config.include FactoryBot::Syntax::Methods
  RUBY
end

run 'bundle install'

git add: '.'
git commit: "-a -m 'add factory_bot_rails gem'"
