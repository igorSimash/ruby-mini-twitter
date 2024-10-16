FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    username { Faker::Internet.username(specifier: "usernameex") }
  end
end
