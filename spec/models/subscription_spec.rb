require 'spec_helper'

describe Subscription do
  subject { build_stubbed(:subscription) }
  it { should be_valid }

  it "is not able to create an empty subscription" do
    build(:subscription, title: nil, releaser: nil).save.should be_false
  end

  it "is able to create a subscription to title" do
    create(:subscription_to_title).should be_true
  end

  it "is not able to create 2 title subscriptions" do
    s1 = create(:subscription_to_title)
    s1.save.should be_true
    s2 = build(:subscription_to_title, title: s1.title, user: s1.user)
    s2.save.should be_false
    s2.should have(1).error_on(:title_id)
  end

  it "is able to create a subscription to releaser" do
    create(:subscription_to_releaser).should be_true
  end

  it "is not able to create 2 releaser subscriptions" do
    s1 = create(:subscription_to_releaser)
    s1.save.should be_true
    s2 = build(:subscription_to_releaser, releaser: s1.releaser, user: s1.user)
    s2.save.should be_false
    s2.should have(1).error_on(:releaser_id)
  end

  it "is able to create a subscription to releaser and a subscription to title" do
    create(:subscription_to_releaser).should be_true
    create(:subscription_to_title).should be_true
  end

  it "is able to create a subscription to releaser and title" do
    create(:subscription).should be_true
  end

  it "is able to create a subscription to releaser and title even if subscription to title OR releaser already exists" do
    create(:subscription_to_releaser).should be_true
    create(:subscription_to_title).should be_true
    create(:subscription).should be_true
  end

  it "is not able to create 2 full subscriptions" do
    s1 = create(:subscription)
    s1.save.should be_true
    s2 = build(:subscription, title: s1.title, user: s1.user, releaser: s1.releaser)
    s2.save.should be_false
    s2.should have(1).error_on(:releaser_id)
  end

  context "creating destroying" do
    subject { Subscription }
    let(:user_id) { build_stubbed(:user).id }

    describe "::create_from_release_ids" do
      let(:release_ids) { 2.times { create(:release) }; Release.all.map(&:id) }

      it "creates subscriptions if they are not exists already" do
        expect { subject.create_from_release_ids(release_ids, user_id) }.to change(Subscription, :count).by(2)
      end

      it "does not create subscriptions if they are already exist" do
        subject.create_from_release_ids(release_ids, user_id)
        expect { subject.create_from_release_ids(release_ids, user_id) }.to_not change(Subscription, :count)
      end
    end

    describe "::destroy_for_user" do
      it "deletes only users subscrptions" do
        create(:subscription, user_id: user_id)
        create(:subscription)
        expect { subject.destroy_for_user(Subscription.all.map(&:id), user_id) }.to change(Subscription, :count).by(-1)
      end
    end
  end
end
