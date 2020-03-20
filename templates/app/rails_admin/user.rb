# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models ||= []

  config.included_models << 'User'
  config.model User do
    list do
      field :email
      field :first_name
      field :last_name
      field :created_at do
        column_width 300
      end
    end
    show do
      field :email
      field :first_name
      field :last_name
      field :created_at
    end
    edit do
      field :email
      field :password
      field :first_name
      field :last_name
      field :created_at
      # field :image, :carrierwave
    end
  end
end
