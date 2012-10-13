FactoryGirl.define do
  factory :release do
    association :releaser
    association :title
    episodes { rand(100).to_s << (rand(2) == 0 ? '' : "x#{rand(100)}") }
    raw { [title.title, releaser.name, episodes].join(' ') }
  end
end
