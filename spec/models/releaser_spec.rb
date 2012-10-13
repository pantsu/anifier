require 'spec_helper'

describe Releaser do
  subject { build_stubbed(:releaser) }
  it { should be_valid }
end
