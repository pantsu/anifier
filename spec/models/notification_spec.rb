require 'spec_helper'

describe Notification do

  subject { Notification }

  before { UserMailer.stub(delay: UserMailer) }
  after  { Rails.redis.del('release-1') }

  describe "::deliver" do
    let(:user)    { create(:user) }
    let(:release) { create(:release) }

    context "unless notification exists" do
      it "sends new release email" do
        UserMailer.should_receive(:new_release).with(user, release)
        subject.deliver(user.id, release.id)
      end

      it "adds notification" do
        subject.should_receive(:add).with(release.id, user.id)
        subject.deliver(user.id, release.id)
      end
    end

    context "if notification exists" do
      before { subject.send(:add, release.id, user.id)}

      it "does not send new release email" do
        UserMailer.should_not_receive(:new_release).with(user, release)
        subject.deliver(user.id, release.id)
      end

      it "does not add notification" do
        subject.should_not_receive(:add).with(release.id, user.id)
        subject.deliver(user.id, release.id)
      end
    end
  end

  describe "::exists?" do
    it "returns true if user is in the set" do
      subject.send(:add, 1, 1)
      subject.send(:exists?, 1, 1).should be_true
    end

    it "returns false if user is not in the set" do
      subject.send(:exists?, 1, 1).should be_false
    end
  end

  describe "::add" do
    it "returns true if user added to release set" do
      subject.send(:add, 1, 1).should be_true
    end

    it "returns false if key is already in the set" do
      subject.send(:add, 1, 1)
      subject.send(:add, 1, 1).should be_false
    end
  end
end
