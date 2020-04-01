# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_sidekiq.rb

inject_into_file 'Gemfile', before: 'group :development do' do
  <<~RUBY
    gem 'sidekiq'

  RUBY
end

run 'bundle install'

inject_into_file 'config/application.rb', after: '  class Application < Rails::Application' do
  <<-'RUBY'

    config.active_job.queue_adapter = :sidekiq
  RUBY
end

git add: '.'
git commit: "-a -m 'add sidekiq gem'"
