require 'spec_helper'

describe ReleaserDecorator do
  let(:releaser) { build_stubbed(:releaser) }
  subject { releaser.decorate }

  describe "#description" do
    its(:description) { should == Release.h(:no_description) }

    specify do
      releaser.description = 'bogus'
      subject.description.should == 'bogus'
    end
  end

  describe "#name_with_link" do
    its(:name_with_link) { should == I18n.t('releaser', name: releaser.name) }

    specify do
      releaser.url = 'http://bogus.com'
      subject.name_with_link.should =~ /http:\/\/bogus\.com/
    end
  end
end