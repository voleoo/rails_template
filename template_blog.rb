# frozen_string_literal: true

# rails new project_name --skip-webpack-install -T -d postgresql -m rails_template/template_blog.rb
# rails app:template LOCATION=../rails_template/template_blog.rb

[
  'install_base.rb',
  'install_webpacker.rb',
  'install_database.rb',
  'install_bootstrap.rb',
  'install_bootstrap_layout.rb',
  'install_rspec.rb',
  'install_factory_bot_rails.rb',
  'install_simplecov.rb',
  'scaffold_user.rb'
].each do |file|
  rails_command "app:template LOCATION=https://raw.githubusercontent.com/voleoo/rails_template/master/#{file}"
end
