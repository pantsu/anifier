FactoryGirl.define do
  factory :subscription do
    association :user
    association :title
  end

  factory :subscription_with_releaser, parent: :subscription do
    association :releaser
  end
end
