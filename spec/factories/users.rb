# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    sequence(:uid) { |n| n.to_s }
    name "MyString"
    sequence(:email) { |n| "user-#{n}@email.com" }
    image "MyString"
    sequence(:oauth_token) { |n| "oauthtoken#{n}" }
    token_expires_at 1.hour.from_now
  end
end
