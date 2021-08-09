# frozen_string_literal: true

# rails app:template LOCATION=../rails_template/install_bootstrap.rb

run 'yarn add bootstrap jquery @popperjs/core'

inject_into_file 'config/webpack/environment.js', after: "const { environment } = require('@rails/webpacker')" do
  <<~'JS'

    const webpack = require('webpack')

    environment.plugins.append('Provide', new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Popper: ['popper.js', 'default']
    }))
  JS
end

inject_into_file 'app/javascript/packs/application.js' do
  <<~'JS'
    import 'bootstrap'
    import './src/application.scss'
  JS
end

run 'mkdir app/javascript/packs/src'
run 'touch app/javascript/packs/src/application.scss'

inject_into_file 'app/javascript/packs/src/application.scss' do
  <<~'JS'
    @import '~bootstrap/scss/bootstrap';
  JS
end
