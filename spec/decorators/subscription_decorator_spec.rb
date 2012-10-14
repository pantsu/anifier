require 'spec_helper'

describe SubscriptionDecorator do
  subject { subscription.decorate }

  describe "#full_title without" do
    let(:subscription) { build_stubbed(:subscription, created_at: Time.now) }
    its(:full_title) { should == "#{subscription.title.name} #{I18n.l(subscription.created_at, format: :short)}" }
  end

  describe "#full_title with releaser" do
    let(:subscription) { build_stubbed(:subscription_with_releaser, created_at: Time.now) }
    its(:full_title) { should == "#{subscription.title.name} #{subscription.releaser.name} #{I18n.l(subscription.created_at, format: :short)}" }
  end
end