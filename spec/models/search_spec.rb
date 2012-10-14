require 'spec_helper'

describe Search do

  before do
    scopes = Search::ORDER_MODES + Search::MATCH_MODES + [:with_audio, :with_video]
    scopes.each { |scope| Release.stub(scope).and_return(Release) }
  end

  specify { search = Search.new("query").should be_valid }

  describe "#results" do
    it "returns an empty Array when instance is not valid" do
      search = Search.new("query", order_mode: "")
      search.results.should be_blank
    end

    it "applies :with_audio scope if the 'audio' option is not blank" do
      search = Search.new("query", audio: 'AAC')
      Release.should_receive(:with_audio).with('AAC')
      search.results
    end

    it "does not apply :with_audio scope if the 'audio' option is blank" do
      search = Search.new("query", audio: '')
      Release.should_not_receive(:with_audio)
      search.results
    end

    it "applies :with_video scope if the 'video' option is not blank" do
      search = Search.new("query", video: 'H264')
      Release.should_receive(:with_video).with('H264')
      search.results
    end

    it "does not apply :with_video scope if the 'video' option is blank" do
      search = Search.new("query", video: '')
      Release.should_not_receive(:with_video)
      search.results
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
        video: 'h264')

      [:by_any_word, :by_relevance, :with_audio, :with_video].each { |scope| Release.should_receive(scope) }
      search.results
    end

  end
end