# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/apply_rubocop.rb

run 'rubocop -a .'

git add: '.'
git commit: "-a -m 'rubocop auto correct'"
