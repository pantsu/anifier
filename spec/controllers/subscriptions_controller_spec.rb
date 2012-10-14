require 'spec_helper'

describe SubscriptionsController do
  before do
    @request.env['HTTP_REFERER'] = root_path
    controller.stub(current_user: stub(id: 1))
  end

  it "redirects back after creating subscriptions" do
    post :create, release_ids: [create(:release).id, create(:release).id]
    response.should redirect_to(root_path)
  end

  %w(release releaser title).each do |model|
    it "creates subscriptions using #{model}" do
      expect { post :create, "#{model}_ids" => [create(model).id, create(model).id] }.to change(Subscription, :count).by(2)
    end
  end

  it "redirects back after deleting subscriptions" do
    delete :destroy, subscription_ids: [create(:subscription).id, create(:subscription).id]
    response.should redirect_to(root_path)
  end
end