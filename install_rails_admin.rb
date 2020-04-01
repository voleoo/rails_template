# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_rails_admin.rb

inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem 'rails_admin'

  RUBY
end

run 'bundle install'

rails_command 'g rails_admin:install rails_admin'

git add: '.'
git commit: "-a -m 'add rails_admin gem'"
