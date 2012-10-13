require 'spec_helper'

describe ReleaseObserver do
  let!(:subscription) { create(:subscription_with_releaser) }

  it "delivers notification" do
    Notification.should_receive(:deliver)
    create(:release, title_id: subscription.title_id, releaser_id: subscription.releaser_id)
  end
end