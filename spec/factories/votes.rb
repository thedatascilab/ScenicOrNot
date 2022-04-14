FactoryBot.define do
  factory :vote do
    place { build(:place) }
    rating { rand(1..10) }
    uuid { Faker::Internet.uuid }
  end
end
