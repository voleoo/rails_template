# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_capybara.rb

repo_url = 'https://raw.githubusercontent.com/voleoo/rails_template/master/templates'

if !File.readlines('Gemfile').grep(/group :test do/).empty?
  inject_into_file 'Gemfile', after: 'group :test do' do
  <<-RUBY

  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  RUBY
  end
else
  gem_group :test do

    gem 'capybara'
    gem 'capybara-screenshot'
    gem 'selenium-webdriver'
  end
end

inject_into_file 'spec/rails_helper.rb', before: 'RSpec.configure do |config|' do
<<-RUBY
Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: ['headless', 'disable-gpu', 'window-size=1200,680'] }
  )

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities
end

js_driver = ENV['USE_BROWSER'] ? :chrome : :headless_chrome
Capybara.javascript_driver = js_driver

Capybara::Screenshot.register_driver(js_driver) do |driver, path|
  driver.browser.save_screenshot(path)
end

RUBY
end

inject_into_file 'spec/rails_helper.rb', after: 'RSpec.configure do |config|' do
  <<-RUBY

  config.include Capybara::DSL
  RUBY
end

run 'bundle install'

[
  'spec/features/home/home_spec.rb'
].each do |file|
  file(file, `curl #{repo_url}/#{file}`)
end

git add: '.'
git commit: "-a -m 'add capybara gem'"
