# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    sequence(:uid) { |n| n.to_s }
    name "MyString"
    sequence(:email) { |n| "user-#{n}@email.com" }
    image "MyString"
    token "MyString"
  end
end
