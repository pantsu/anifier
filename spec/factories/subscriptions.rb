FactoryGirl.define do
  factory :subscription, class: 'Subscription' do
    association :user
    association :releaser
    association :title
  end

  factory :subscription_to_title, class: 'Subscription' do
    association :user
    association :title
  end

  factory :subscription_to_releaser, class: 'Subscription' do
    association :user
    association :releaser
  end
end
