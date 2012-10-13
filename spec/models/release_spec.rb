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
    let(:attributes) { API::RELEASE_ATTRIBUTES.inject({}) { |hsh, attr| hsh[attr] = attr; hsh } }

    it "raises error if unknown attribute is passed" do
      expect { subject.create_from_parsed_data(some_shit: 'some_shit', same_shit: 'same_shit') }\
        .to raise_error(ActiveRecord::UnknownAttributeError)
    end

    it "creates new release" do
      instance = subject.create_from_parsed_data(attributes)
      instance.should be_persisted
    end

    it "sets all passed attributes" do
      instance = subject.create_from_parsed_data(attributes)
      attributes.keys.each { |attr| instance.send(attr).should == attr unless attr.in?([:title, :releaser]) }
      [:title, :releaser].each { |attr| instance.send(attr).should be_instance_of(attr.to_s.classify.constantize) }
    end

    %w(title releaser).each do |assoc|
      it "creates new #{assoc} is there is no needed one" do
        expect { subject.create_from_parsed_data(attributes) }.to change(assoc.classify.constantize, :count).by(1)
      end

      it "does not create new #{assoc} if the one needed is already present" do
        klass = assoc.classify.constantize
        klass.create(name: assoc)
        expect { subject.create_from_parsed_data(attributes) }.to_not change(klass, :count).by(1)
      end
    end
  end
end
