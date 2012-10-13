require 'spec_helper'

describe User do
  subject { build_stubbed(:user) }
  it { should be_valid }
end
