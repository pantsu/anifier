require 'spec_helper'

describe Notification do

  before { UserMailer.stub(delay: UserMailer) }
  after  { Rails.redis.del('release-1') }

  let(:release) { create(:release) }

  subject { Notification.new(release) }

  describe "::deliver_to" do

    let(:user) { create(:user) }

    context "unless notification exists" do
      it "sends new release email" do
        UserMailer.should_receive(:new_release).with(user, release)
        subject.deliver_to(user)
      end

      it "adds notification" do
        subject.should_receive(:add).with(user.id)
        subject.deliver_to(user)
      end
    end

    context "if notification exists" do
      before { subject.send(:add, user.id)}

      it "does not send new release email" do
        UserMailer.should_not_receive(:new_release).with(user, release)
        subject.deliver_to(user)
      end

      it "does not add notification" do
        subject.should_not_receive(:add).with(user.id)
        subject.deliver_to(user)
      end
    end
  end

  describe ".deliver_toed_to?" do
    it "returns true if user is in the set" do
      subject.send(:add, 1)
      subject.send(:delivered_to?, 1).should be_true
    end

    it "returns false if user is not in the set" do
      subject.send(:delivered_to?, 0).should be_false
    end
  end

  describe ".add" do
    it "returns true if user added to release set" do
      subject.send(:add, 1).should be_true
    end

    it "returns false if key is already in the set" do
      subject.send(:add, 1)
      subject.send(:add, 1).should be_false
    end
  end
end
