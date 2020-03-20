# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_simplecov.rb

inject_into_file 'Gemfile', after: 'group :test do' do
  <<-RUBY.chomp
  gem 'simplecov'
  RUBY
end

run 'bundle install'

inject_into_file 'spec/rails_helper.rb', before: 'RSpec.configure do |config|' do
  <<~'RUBY'
    SimpleCov.start do
      groups = %w[controllers models helpers services jobs decorators]
      groups.each { |name| add_group name.capitalize, "/app/#{name}" }

      add_filter '/config/'
      add_filter '/spec/'
      add_filter '/test/'
      add_filter '/.bundle/'
    end

  RUBY
end

inject_into_file '.gitignore', "coverage\n"

git add: '.'
git commit: "-a -m 'add simplecov gem'"
