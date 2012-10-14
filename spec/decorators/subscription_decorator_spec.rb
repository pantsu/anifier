require 'spec_helper'

describe SubscriptionDecorator do
  subject { subscription.decorate }

  describe "#full_title" do
    let(:subscription) { build_stubbed(:subscription, created_at: Time.now) }
    its(:full_title) { should == "#{subscription.title.name} #{subscription.releaser.name} #{I18n.l(subscription.created_at, format: :short)}" }
  end

  describe "#full_title with only releaser" do
    let(:subscription) { build_stubbed(:subscription_to_releaser, created_at: Time.now) }
    its(:full_title) { should == "#{subscription.releaser.name} #{I18n.l(subscription.created_at, format: :short)}" }
  end

  describe "#full_title with only title" do
    let(:subscription) { build_stubbed(:subscription_to_title, created_at: Time.now) }
    its(:full_title) { should == "#{subscription.title.name} #{I18n.l(subscription.created_at, format: :short)}" }
  end
end