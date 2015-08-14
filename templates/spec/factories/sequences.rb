FactoryGirl.define do
  sequence :email do |n|
    "email-#{n}@example.local"
  end
end
