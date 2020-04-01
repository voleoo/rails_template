# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/scaffold_user.rb

repo_url = 'https://raw.githubusercontent.com/voleoo/rails_template/master/templates'

inject_into_file 'config/application.rb', after: '  class Application < Rails::Application' do
  <<-'RUBY'

    config.generators.assets false
    config.generators.helper false
    config.generators.stylesheets false
  RUBY
end

rails_command 'generate model user email:string:uniq password:string first_name:string last_name:string --no-test-framework'

[
  'spec/factories/sequences.rb',
  'spec/factories/users.rb',
  'spec/models/user_spec.rb',
  'app/rails_admin/user.rb'
].each do |file|
  file(file, `curl #{repo_url}/#{file}`)
end

rails_command 'db:migrate'

git add: '.'
git commit: "-a -m 'scaffold user'"
