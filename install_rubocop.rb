# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_rubocop.rb

inject_into_file 'Gemfile', after: 'group :development do' do
  <<-RUBY.chomp

  gem 'rubocop', require: false
  RUBY
end

run 'rubocop -a'

git add: '.'
git commit: "-a -m 'rubocop auto correct'"
