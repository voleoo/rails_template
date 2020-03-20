# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_bootstrap_layout.rb

repo_url = 'https://raw.githubusercontent.com/voleoo/rails_template/master/templates'

[
  'app/controllers/home_controller.rb',
  'app/views/home/index.html.erb',
  'app/views/shared/_header.html.erb',
  'app/views/shared/_footer.html.erb',
  'app/views/shared/_flash.html.erb'
].each do |file|
  file(file, `curl #{repo_url}/#{file}`)
end

route "root to: 'home#index'"

gsub_file 'app/views/layouts/application.html.erb', '    <%= yield %>', <<-RUBY.chomp
    <div class="container-fluid">
      <div class="container border-bottom px-0">
        <%= render 'shared/flash' %>
      </div>
    </div>
    <div class="container-fluid">
      <div class="container border-bottom px-0">
        <%= render 'shared/header' %>
      </div>
    </div>
    <div class="container-fluid">
      <div class="container px-0"><%= yield %></div>
    </div>
    <div class="container-fluid">
      <div class="container border-top px-0">
        <%= render 'shared/footer' %>
      </div>
    </div>
RUBY
