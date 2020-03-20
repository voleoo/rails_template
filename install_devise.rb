# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_devise.rb

inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem 'devise'
    gem 'devise-bootstrap-views'

  RUBY
end

run 'bundle install'

rails_command 'generate devise:install'
rails_command 'generate devise user'
rails_command 'generate devise:views:bootstrap_templates'

inject_into_file 'config/environments/development.rb', after: 'config.action_mailer.perform_caching = false' do
  <<-RUBY.chomp

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
end

file_migration = Dir['db/migrate/*_add_devise_to_users.rb'].first
gsub_file file_migration, /^\s*.*RAILS_ENV=development.*\n/, ''
gsub_file file_migration, /^\s*.*string :email.*\n/, ''
gsub_file file_migration, /^\s*.*users, :email.*\n/, ''

rails_command 'db:migrate'

git add: '.'
git commit: "-a -m 'add devise gem'"
