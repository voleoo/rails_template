# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_spree.rb

inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem 'spree', '~> 4.1.1'
    gem 'spree_auth_devise', '~> 4.1'
    gem 'spree_gateway', '~> 3.7'

  RUBY
end

run 'bundle update'

#########################
# rails_command g spree:install --migrate=false --sample=false --seed=false --copy_storefront=false
# OR
# run 'rake railties:install:migrations'
# rails_command 'db:migrate'
# rails_command 'db:seed'
# run 'rake spree_sample:load'
# rails_command 'g spree:frontend:copy_storefront'
#########################
rails_command 'g spree:install'
#########################

rails_command 'g spree:auth:install'
rails_command 'g spree_gateway:install'

git add: '.'
git commit: "-a -m 'add spree gem'"
