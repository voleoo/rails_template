#lock '3.4.0'

set :application, '<%= app_name %>'
set :repo_url, '<%= repo_url %>'
set :branch, 'master'

set :use_sudo, false
set :deploy_via, :copy
set :keep_releases, 10

set :rvm_type, :user

set :linked_files, %w{ config/database.yml config/application.yml }
set :linked_dirs, %w{ db/backup log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/sitemaps}

set :puma_init_active_record, true
