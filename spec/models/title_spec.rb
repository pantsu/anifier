require 'spec_helper'

describe Title do
  subject { build_stubbed(:title) }
  it { should be_valid }
end
