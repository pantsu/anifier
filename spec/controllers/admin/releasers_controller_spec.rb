require 'spec_helper'

describe Admin::ReleasersController do

  actions_and_methods = { index: :get, edit: :get, update: :put, destroy: :delete }

  context "when user is not logged in" do
    actions_and_methods.each do |action, method|
      before { controller.stub(current_user: nil) }
      it "has no access to the #{action} action" do
        expect { send(method, action, id: create(:releaser).to_param) }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  context "if user is not an admin" do
    actions_and_methods.each do |action, method|
      before { controller.stub(current_user: stub(admin?: false)) }
      it "has no access to the #{action} action" do
        expect { send(method, action, id: create(:releaser).to_param) }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  context "if user is an admin" do
    before { controller.stub(current_user: stub(admin?: true)) }

    it "successfully renders #index action" do
      Release.paginates_per(3)
      3.times { create(:releaser) }
      get :index
      response.should be_success
    end

    it "successfully renders #edit action" do
      get :edit, id: create(:releaser).to_param
      response.should be_success
    end

    it "successfully updates release" do
      put :update, id: create(:releaser).to_param
      response.should redirect_to(admin_releasers_path)
    end

    it "successfully deletes release" do
      delete :destroy, id: create(:releaser).to_param
      response.should redirect_to(admin_releasers_path)
    end
  end
end