FactoryGirl.define do
  factory :title do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
