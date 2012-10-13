require 'spec_helper'

describe Subscription do
  subject { build_stubbed(:subscription) }
  it { should be_valid }

  it "can be general title subscription" do
    create(:subscription).should be_true
  end

  it "can not be 2 general title subscriptions" do
    s1 = create(:subscription)
    s1.save.should be_true
    s2 = build(:subscription, title: s1.title, user: s1.user)
    s2.save.should be_false
    s2.should have(1).error_on(:title_id)
  end

  it "can be releaser specific subscription if there is not general one" do
    create(:subscription_with_releaser).should be_true
  end

  it "can not be 2 releaser specific subscriptions" do
    s1 = create(:subscription_with_releaser)
    s1.save.should be_true
    s2 = build(:subscription_with_releaser, title: s1.title, user: s1.user, releaser: s1.releaser)
    s2.save.should be_false
    s2.should have(1).error_on(:releaser_id)
  end
end
