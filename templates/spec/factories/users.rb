# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email
    password { SecureRandom.base64 }
    first_name
    last_name
  end
end
