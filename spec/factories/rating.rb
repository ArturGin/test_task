FactoryBot.define do
  factory :rating do
    value { rand(1..5) }
    post { create(:post) }
    user { create(:user) }
  end
end
