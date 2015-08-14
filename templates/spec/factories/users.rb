FactoryGirl.define do
  factory :user do
    email
    password SecureRandom.base64
  end
end
