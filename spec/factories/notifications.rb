FactoryGirl.define do
  factory :notification do
    association :user
    association :release
  end
end
