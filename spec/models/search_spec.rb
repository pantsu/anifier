require 'spec_helper'

describe Search do

  before do
    scopes = Search::ORDER_MODES + Search::MATCH_MODES + [:with_audio, :with_video, :with_resolution]
    scopes.each { |scope| Release.stub(scope).and_return(Release) }
  end

  specify { search = Search.new("query").should be_valid }

  describe "#results" do
    it "returns an empty Array when instance is not valid" do
      search = Search.new("query", order_mode: "")
      search.results.should be_blank
    end

    context "using :with_audio scope" do
      it "applies :with_audio scope if the 'audio' option is not blank" do
        search = Search.new("query", audio: 'AAC')
        Release.should_receive(:with_audio).with('AAC')
        search.results
      end

      it "does not apply :with_audio scope if the 'audio' option is blank" do
        search = Search.new("query")
        Release.should_not_receive(:with_audio)
        search.results
      end
    end

    context "using :with_video scope" do
      it "applies :with_video scope if the 'video' option is not blank" do
        search = Search.new("query", video: 'H264')
        Release.should_receive(:with_video).with('H264')
        search.results
      end

      it "does not apply :with_video scope if the 'video' option is blank" do
        search = Search.new("query")
        Release.should_not_receive(:with_video)
        search.results
      end
    end

    context "using :with_resolution scope" do
      it "applies :with_resolution scope if the 'resolution' option is not blank" do
        search = Search.new("query", resolution: '720')
        Release.should_receive(:with_resolution).with('720')
        search.results
      end

      it "does not apply :resolution scope if the 'resolution' option is blank" do
        search = Search.new("query", resolution: '')
        Release.should_not_receive(:with_resolution)
        search.results
      end
    end

    context "using :with_releaser_id scope" do
      it "applies :with_releaser_id scope if the 'releaser_id' option is not blank" do
        search = Search.new("query", releaser_id: '1')
        Release.should_receive(:with_releaser_id).with('1')
        search.results
      end

      it "does not apply :with_releaser_id scope if the 'releaser_id' option is blank" do
        search = Search.new("query", releaser_id: '')
        Release.should_not_receive(:with_releaser_id)
        search.results
      end
    end

    Search::ORDER_MODES.each do |mode|
      it "applies #{mode.inspect} scope if :order_mode option is set to #{mode.inspect}" do
        search = Search.new("query", order_mode: mode)
        Release.should_receive(mode)
        search.results
      end
    end

    Search::MATCH_MODES.each do |mode|
      it "applies #{mode.inspect} scope if :match_mode option is set to #{mode.inspect}" do
        search = Search.new("query", match_mode: mode)
        Release.should_receive(mode)
        search.results
      end
    end

    it "chains thinking sphinx scopes" do
      search = Search.new("query",
        match_mode: 'by_any_word',
        order_mode: 'by_relevance',
        audio: 'aac',
        video: 'h264',
        resolution: '720')

      [:by_any_word, :by_relevance, :with_audio, :with_video, :with_resolution].each do |scope|
        Release.should_receive(scope)
      end
      search.results
    end

  end
end