# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_rspec.rb

repo_url = 'https://raw.githubusercontent.com/voleoo/rails_template/master/templates'

if !File.readlines('Gemfile').grep(/group :test do/).empty?
  inject_into_file 'Gemfile', after: 'group :development, :test do' do
    <<-RUBY.chomp
    gem 'rspec-rails'
    RUBY
  end
else
  gem_group :test do
    gem 'rspec-rails'
  end
end

run 'bundle install'

rails_command 'generate rspec:install'

inject_into_file 'config/application.rb', after: '  class Application < Rails::Application' do
  <<-'RUBY'

    config.generators.test_framework :rspec
  RUBY
end

inject_into_file 'spec/rails_helper.rb', after: 'RSpec.configure do |config|' do
  <<-RUBY

  config.include Rails.application.routes.url_helpers
  RUBY
end

append_to_file '.rspec', "--color\n"

[
  'spec/controllers/home_controller_spec.rb'
].each do |file|
  file(file, `curl #{repo_url}/#{file}`)
end

git add: '.'
git commit: "-a -m 'add rspec-rails gem'"
