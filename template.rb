run 'echo "coverage" >> .gitignore'
repo_url = 'https://raw.githubusercontent.com/voleoo/rails_template/master/templates/'

file '.ruby-gemset', "#{app_name}\n"
file '.ruby-version', "#{RUBY_VERSION}\n"

inject_into_file 'config/application.rb', :after => 'config.i18n.default_locale = :de' do <<-'RUBY'


    config.generators do |g|
      g.test_framework :rspec
      g.factory_girl false
    end

    config.active_job.queue_adapter = :sidekiq
RUBY
end

inject_into_file 'config/environments/development.rb', :after => 'config.action_mailer.raise_delivery_errors = false' do <<-'RUBY'

    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
RUBY
end
##############################################################
file 'config/database.yml', <<-FILE
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
run 'echo "config/database.yml" >> .gitignore'
##############################################################
file 'config/application.yml', `curl #{repo_url}config/application.yml`
run 'cp config/application.yml config/application.example.yml'
run 'echo "config/application.yml" >> .gitignore'
##############################################################

[
  'app/controllers/home_controller.rb',
  'app/jobs/user_job.rb',
  'app/models/user.rb',
  'app/services/user_service.rb',
  'app/views/home/index.html.slim',

  'config/deploy/production.rb',
  'config/initializers/devise.rb',
  'config/initializers/rails_admin.rb',
  'config/locales/devise.en.yml',
  'config/deploy.rb',
  'config/routes.rb',
  'config/schedule.rb',

  'db/migrate/20150901000000_devise_create_users.rb',

  'lib/tasks/user_processor.rake',

  'spec/controllers/home_controller_spec.rb',
  'spec/controllers/users_controller_spec.rb',
  'spec/factories/sequences.rb',
  'spec/factories/users.rb',
  'spec/jobs/user_job_spec.rb',
  'spec/models/user_spec.rb',
  'spec/services/user_service_spec.rb',
  'spec/support/requests_helper.rb',
  'spec/tasks/user_processor.rake',
  'spec/spec_helper.rb',

  '.rspec',
  'Capfile',
  'Gemfile'
].each do |file|
  file(file, `curl #{repo_url}#{file}`)
end

user = ask('Which user will be used on server:')
server = ask('Which server will be used:')

gsub_file 'config/initializers/devise.rb', "# config.secret_key = '8748c34b87775", "config.secret_key = '#{rand(10000000000)}8748c34b87775"

gsub_file 'config/deploy/production.rb', '<%= user %>', user
gsub_file 'config/deploy/production.rb', '<%= server %>', server
gsub_file 'config/deploy/production.rb', '<%= app_name %>', app_name
gsub_file 'config/deploy/production.rb', '<%= ruby_version %>', RUBY_VERSION

gsub_file 'config/deploy.rb', '<%= app_name %>', app_name

gsub_file 'config/schedule.rb', '<%= user %>', user
gsub_file 'config/schedule.rb', '<%= app_name %>', app_name

run 'bundle install -j4'
run 'bundle exec spring binstub --all'
run 'bundle exec rake db:create'
run 'bundle exec rake db:migrate'

git :init
git add: '.'
git commit: "-m 'First commit'"
git remote: "add origin git@bitbucket.org:voleoo/#{app_name}.git" 
