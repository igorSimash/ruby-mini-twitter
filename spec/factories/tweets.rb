FactoryBot.define do
  factory :tweet do
    body { Faker::Lorem.sentence(word_count: 20) }
    association :user
  end
end
