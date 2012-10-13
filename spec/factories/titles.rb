FactoryGirl.define do
  factory :title do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
