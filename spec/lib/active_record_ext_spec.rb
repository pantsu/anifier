require 'spec_helper'

describe 'ActiveRecordExt' do
  subject { Notification }
  it { be_respond_to(:for_user) }
  it { be_respond_to(:for_release) }

  context "fetch only needed instances" do
    before { 2.times { create(:notification) } }
    let(:n) { Notification.last }

    specify "when instance passed" do
      subject.for_user(n.user).for_release(n.release).should == [n]
    end

    it "does ids passed" do
      subject.for_user(n.user_id).for_release(n.release_id).should == [n]
    end
  end
end