require 'spec_helper'

describe ReleaseObserver do
  let!(:subscription) { create(:subscription) }

  it "delivers notification" do
    Notification.any_instance.should_receive(:deliver_to)
    create(:release, title_id: subscription.title_id, releaser_id: subscription.releaser_id)
  end

  it "respects partial subscriptions" do
    create(:subscription_to_title, title: subscription.title)
    create(:subscription_to_releaser, releaser: subscription.releaser)

    notification = mock(:notification, deliver_to: true)
    Notification.should_receive(:new).exactly(3).times.and_return(notification)
    create(:release, title_id: subscription.title_id, releaser_id: subscription.releaser_id)
  end
end