require 'spec_helper'

describe Notification do
  subject { build_stubbed(:notification) }
  it { should be_valid }
end
