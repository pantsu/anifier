require 'spec_helper'

describe SubscriptionsController do
  before do
    controller.stub(current_user: stub(id: 1, admin?: false))
  end

  describe "#create" do
    it "returns success = false on failure" do
      release = create(:release)
      create(:subscription, title_id: release.title_id, releaser_id: release.releaser_id, user_id: 1)

      post :create, subscription: {title_id: release.title_id, releaser_id: release.releaser_id}

      response.should be_success
      json = JSON.parse(response.body)
      json['success'].should be_false
      json['message'].should_not be_blank
    end

    it "allows to create a subcription to releaser" do
      post :create, subscription: {releaser_id: create(:releaser).id}
      response.should be_success
      json = JSON.parse(response.body)
      json['success'].should be_true
      json['message'].should_not be_blank
    end

    it "allows to create a subcription to title" do
      post :create, subscription: {title_id: create(:title).id}
      response.should be_success
      json = JSON.parse(response.body)
      json['success'].should be_true
      json['message'].should_not be_blank
    end

    it "allows to create a subcription to title and releaser" do
      post :create, subscription: {title_id: create(:title).id, releaser_id: create(:releaser).id}
      response.should be_success
      json = JSON.parse(response.body)
      json['success'].should be_true
      json['message'].should_not be_blank
    end
  end

  describe "#destroy" do
    it "responds with message" do
      subscription = create(:subscription)
      delete :destroy, id: subscription.id
      response.should be_success
      json = JSON.parse(response.body)
      json['success'].should be_true
      json['notice'].should_not be_blank
    end
  end
end