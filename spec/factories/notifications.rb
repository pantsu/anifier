FactoryGirl.define do
  factory :notification do
    %w(user title releaser release).each do |assoc|
      association assoc
    end
  end
end
