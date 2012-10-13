require "spec_helper"

describe UserMailer do
  describe "#new_release" do
    subject { UserMailer.new_release(user, release).deliver }
    let(:user)    { build_stubbed(:user) }
    let(:release) { build_stubbed(:release) }

    it "successfully sends" do
      subject
      ActionMailer::Base.deliveries.should_not be_empty
    end

    its(:to)      { should == [user.email] }
    its(:subject) { should == "Anifier: New release of #{release.title_name} by #{release.releaser_name}" }
  end
end