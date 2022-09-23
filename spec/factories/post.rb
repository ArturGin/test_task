FactoryBot.define do
  factory :post do
    sequence(:title, 'a') { |n| "title#{n}" }
    sequence(:body, 'a') { |n| "body#{n}" }
    user { create(:user) }
    sequence(:ip, 'a') { |n| "ip#{n}" }
  end

  trait :with_ratings do
    after(:create) do |post|
      create :rating, user_id: post.user.id, post_id: post.id, value: rand(1..5)
    end
  end
end
