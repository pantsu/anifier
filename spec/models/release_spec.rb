require 'spec_helper'

describe Release do
  subject { build_stubbed(:release) }
  it { should be_valid }
end
