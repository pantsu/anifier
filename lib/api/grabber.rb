class API::Grabber

  def initialize(url)
    @url = url
    @parser = StandardParser.new
  end

  def reset!
    @releases = nil
  end

  def releases
    return @releases unless @releases.nil?
    feed = Feedzirra::Feed.fetch_and_parse(@url)
    if feed.respond_to?(:entries)
      @releases = feed.entries.map { |entry| parse_release(entry) }.compact
    else
      @releases = []
    end
  end

  private

  def parse_release(entry)
    entry.title.force_encoding('UTF-8')
    release = API::Release.build(entry.title, @parser.parse(entry.title))
    release && release.valid? ? release : nil
  end

end

ActiveSupport.run_load_hooks(:grabber, self)
