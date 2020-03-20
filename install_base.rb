# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_base.rb

gsub_file 'Gemfile', /^\s*#.*\n/, ''
gsub_file 'Gemfile', /^  gem\s+["']byebug["'].*\n/, ''
gsub_file 'Gemfile', /^  gem\s+["']web-console["'].*\n/, ''
gsub_file 'Gemfile', /^gem\s+["']tzinfo-data["'].*\n/, ''

inject_into_file 'Gemfile', after: 'group :development, :test do' do
  <<-RUBY.chomp
  gem 'pry-byebug'
  RUBY
end

run 'bundle install'

git :init
git add: '.'
git commit: "-a -m 'initial commit'"
