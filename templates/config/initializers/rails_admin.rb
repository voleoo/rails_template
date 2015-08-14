RailsAdmin.config do |config|

  config.authorize_with do
    authenticate_or_request_with_http_basic("") do |username, password|
      username == ENV['RAILS_ADMIN_USER'] && password == ENV['RAILS_ADMIN_PASSWORD']
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.included_models = []

  config.included_models << 'User'
  config.model User do
    list do
      field :email
      field :created_at do
        column_width 300
      end
    end
    show do
      field :email
      field :created_at
    end
    edit do
      field :email
      field :password
      field :created_at
      #field :image, :carrierwave
    end
  end
end
