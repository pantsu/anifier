require 'spec_helper'

describe Release do
  subject { build_stubbed(:release) }
  it { should be_valid }

  describe "sphinx search" do
    describe "indexes" do
      subject { Release }
      it { should be_indexed_by_sphinx }
      it { should be_delta_indexed_by_sphinx }
      it { should have_search_index_for(:media) }
      it { should have_search_index_for(:title, :name) }
      it { should have_search_attribute_for(:releaser_id) }
      it { should have_search_attribute_for(:created_at) }
      it { should have_search_attribute_for("crc32(audio)") }
      it { should have_search_attribute_for("crc32(video)") }
    end
  end

  describe ".import" do
    subject { Release }
    let(:attributes) { API::RELEASE_ATTRIBUTES.inject({}) { |hsh, attr| hsh[attr] = attr; hsh } }

    it "raises error if unknown attribute is passed" do
      expect { subject.import(bogus: 'bogus') }\
        .to raise_error(ActiveRecord::UnknownAttributeError)
    end

    it "creates new release" do
      instance = subject.import(attributes)
      instance.should be_persisted
    end

    it "sets all passed attributes" do
      instance = subject.import(attributes)
      attributes.keys.each { |attr| instance.send(attr).should == attr unless attr.in?([:title, :releaser]) }
      [:title, :releaser].each { |attr| instance.send(attr).should be_instance_of(attr.to_s.classify.constantize) }
    end

    %w(title releaser).each do |assoc|
      it "creates a new #{assoc.classify} if there is no needed one" do
        expect { subject.import(attributes) }.to change(assoc.classify.constantize, :count).by(1)
      end

      it "does not create a new #{assoc.classify} if the one needed is already present" do
        klass = assoc.classify.constantize
        klass.create(name: assoc)
        expect { subject.import(attributes) }.to_not change(klass, :count).by(1)
      end
    end
  end

  context "decorated" do
    describe "#issue" do 
      it "uses both volume and episode, if possible" do
        build_stubbed(:release, volume: "3", episodes: "12-15").decorate.issue.should == "vol. 3, ep. 12-15"
      end

      it "uses volume when volume is not blank and episodes are not specified" do
        build_stubbed(:release, volume: "3", episodes: nil).decorate.issue.should == "vol. 3"
      end

      it "uses episodes when episodes are not blank and volume is not specified" do
        build_stubbed(:release, volume: nil, episodes: "12-15").decorate.issue.should == "ep. 12-15"
      end
    end
  end
end
