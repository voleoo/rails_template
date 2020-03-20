# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_webpacker.rb

rails_command 'webpacker:install'

git :init
git add: '.'
git commit: "-a -m 'webpacker:install'"
