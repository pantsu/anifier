require 'spec_helper'

describe Release do
  subject { build_stubbed(:release) }
  it { should be_valid }

  describe "sphinx search" do
    describe "indexes" do
      subject { Release }
      it { should be_indexed_by_sphinx }
      it { should be_delta_indexed_by_sphinx }
      it { should have_search_index_for(:audio) }
      it { should have_search_index_for(:video) }
      it { should have_search_index_for(:media) }
      # it { should have_search_index_for(:title) }
      it { should have_search_attribute_for(:releaser_id) }
      it { should have_search_attribute_for(:created_at) }
    end
  end
end
