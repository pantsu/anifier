require 'spec_helper'

describe 'ActiveRecordExt' do
  subject { Subscription }
  it { be_respond_to(:for_user) }
  it { be_respond_to(:for_title) }
  it { be_respond_to(:for_releaser) }

  context "fetch only needed instances" do
    before { 2.times { create(:subscription) } }
    let(:s) { Subscription.last }

    specify "when instance passed" do
      subject.for_user(s.user).for_title(s.title).for_releaser(s.releaser).should == [s]
    end

    it "when ids passed" do
      subject.for_user(s.user_id).for_title(s.title_id).for_releaser(s.releaser_id).should == [s]
    end
  end
end