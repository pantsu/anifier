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

  describe "::create_from_parsed_data" do
    subject { Release }
    let(:attributes) { [:raw, :releaser, :title, :episodes, :volume, :extension, :audio, :video, :media, :resolution, :crc32].inject({}) { |hsh, attr| hsh[attr] = attr; hsh } }

    it "raises error if unknown attribute is passed" do
      expect { subject.create_from_parsed_data(some_shit: 'some_shit', same_shit: 'same_shit') }\
        .to raise_error(ActiveRecord::UnknownAttributeError)
    end

    it "creates new release" do
      instance = subject.create_from_parsed_data(attributes).should be_true
    end

    # it "sets all passed attributes" do
    #   instance = subject.create_from_parsed_data(attributes)
    #   attributes.keys.each { |attr| instance.send(attr).should == attr }
    # end

    %w(title releaser).each do |assoc|
      it "creates new #{assoc} is there is no needed one" do

      end

      it "does not create new #{assoc} if the one needed is already present" do

      end
    end
  end
end
