# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_database.rb

file 'config/database.yml', <<~FILE
  development: &default
    adapter: postgresql
    database: #{app_name}_development
    encoding: utf8
    pool: 5

  test:
    <<: *default
    database: #{app_name}_test

  staging:
    <<: *default
    database: #{app_name}_staging

  production:
    <<: *default
    database: #{app_name}
FILE

run 'cp config/database.yml config/database.example.yml'
inject_into_file '.gitignore', "config/database.yml\n"

rails_command 'db:create'
rails_command 'db:migrate'

git add: '.'
git commit: "-a -m 'modify databse.yml and rake db:create, rake db:migrate'"
