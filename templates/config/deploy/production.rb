# frozen_string_literal: true

role :web,            '<%= user %>@<%= server %>', primary: true
role :app,            '<%= user %>@<%= server %>'
role :db,             '<%= user %>@<%= server %>'
role :old_server,     '<%= user %>@<%= server %>'

server '<%= server %>', user: '<%= user %>', roles: %w[web app]

set :deploy_to, '/home/<%= user %>/sites/<%= app_name %>'
set :rvm_ruby_version, 'ruby-<%= ruby_version %>@<%= app_name %> --create'
set :rails_env, 'production'

set :whenever_identifier, '<%= app_name %>_production'
set :whenever_roles, -> { %i[app web] }

# set :puma_default_hooks, false
# set :sidekiq_default_hooks, false

namespace :deploy do
  desc 'Setup production'
  task :setup do
    on roles(:all) do
      execute("mkdir -p #{deploy_to}/shared/config/")
      upload!('config/database.yml', "#{deploy_to}/shared/config/database.yml")
      upload!('config/application.yml', "#{deploy_to}/shared/config/application.yml")
      execute('cat ~/.ssh/id_rsa.pub')
    end
  end
end

namespace :db do
  task :backup do
    on roles(:old_server) do
      execute("mkdir -p #{shared_path}/tmp/db_backups")
      @database = YAML.safe_load(File.new('config/database.yml', 'r'))['production'].symbolize_keys
      puts @database[:adapter]
      if @database[:adapter] == 'postgresql'
        execute "PGPASSWORD=#{@database[:password]} PGUSER=#{@database[:user]} pg_dump -Fc #{@database[:database]} > #{shared_path}/tmp/db_backups/#{@database[:database]}_production.dump"
      end
      system('mkdir -p tmp/db_backups')
      system("scp #{fetch(:deploy_user)}@#{host}:#{shared_path}/tmp/db_backups/#{@database[:database]}_production.dump tmp/db_backups/#{@database[:database]}_production.dump")
      execute("rm #{shared_path}/tmp/db_backups/#{@database[:database]}_production.dump")
    end
  end

  task :restore do
    on roles(:db) do
      @database = YAML.safe_load(File.new('config/database.yml', 'r'))['production'].symbolize_keys
      execute "mkdir -p #{shared_path}/tmp/db_backups"
      upload!("tmp/db_backups/#{@database[:database]}_production.dump", "#{shared_path}/tmp/db_backups/#{@database[:database]}_production.dump")
      if @database[:adapter] == 'postgresql'
        execute 'sudo /etc/init.d/postgresql restart'
        execute "PGPASSWORD=#{@database[:password]} PGUSER=#{@database[:user]} pg_restore -d #{@database[:database]} #{shared_path}/tmp/db_backups/#{@database[:database]}_production.dump"
      end
    end
  end
end

namespace :uploads do
  task :backup do
    on roles(:old_server) do
      execute("mkdir -p  #{shared_path}/tmp/uploads_backups")
      execute "tar -cvf #{shared_path}/tmp/uploads_backups/uploads_production.tar -C #{shared_path}/public uploads"
      system('mkdir -p tmp/uploads_backups')
      system("scp #{fetch(:deploy_user)}@#{host}:#{shared_path}/tmp/uploads_backups/uploads_production.tar tmp/uploads_backups/uploads_production.tar")
      execute("rm #{shared_path}/tmp/uploads_backups/uploads_production.tar")
    end
  end

  task :restore do
    on roles(:web) do
      execute "mkdir -p #{shared_path}/tmp/uploads_backups"
      upload!('tmp/uploads_backups/uploads_production.tar', "#{shared_path}/tmp/uploads_backups/uploads_production.tar")
      execute "tar -xvf #{shared_path}/tmp/uploads_backups/uploads_production.tar -C #{shared_path}/public/"
      execute("rm #{shared_path}/tmp/uploads_backups/uploads_production.tar")
    end
  end
end
