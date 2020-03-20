# frozen_string_literal: true

# rails new my_store --skip-webpack-install -T -d postgresql -m rails_template/template_spree_shop.rb

[
  'install_base.rb',
  'install_database.rb',
  'install_spree.rb'
  # 'install_rspec.rb',
  # 'install_factory_bot_rails.rb',
  # 'install_simplecov.rb',
].each do |file|
  rails_command "app:template LOCATION=https://raw.githubusercontent.com/voleoo/rails_template/master/#{file}"
end
