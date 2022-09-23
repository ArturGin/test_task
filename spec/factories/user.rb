FactoryBot.define do
  factory :user do
    sequence(:login, 'a') { |n| "login#{n}" }
  end
end
