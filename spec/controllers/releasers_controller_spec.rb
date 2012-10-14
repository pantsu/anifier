require 'spec_helper'

describe ReleasersController do
  it "successfully renders #index action" do
    Release.paginates_per(3)
    3.times { create(:releaser) }
    get :index
    response.should be_success
  end
end