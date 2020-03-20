# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email-#{n}@example.local"
  end

  sequence :first_name do |n|
    "first_name_#{n}"
  end

  sequence :last_name do |n|
    "last_name_#{n}"
  end
end
