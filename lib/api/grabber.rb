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
    @releases = []

    feed = Feedzirra::Feed.fetch_and_parse(@url)
    if feed.respond_to?(:entries)
      @releases = feed.entries.map { |entry| parse_release(entry) }.compact
      logger.info "Grabbed: #{@releases.size} / #{feed.entries.count} from #{@url}"
    else
      logger.error "Feed #{@url} is empty"
    end

    @releases
  end

  private

  def logger
    @logger ||= begin
      log = Logger.new(Rails.root.join("log/grabber.#{Rails.env}.log"))
      log.level = Logger::DEBUG
      log.formatter = lambda do |severity, datetime, progname, message|
        "[#{datetime.strftime("%Y-%m-%d %H:%M:%S")}] #{message}\n"
      end
      log
    end
  end

  def parse_release(entry)
    release = API::Release.build(entry.title, @parser)
    release && release.valid? ? release : nil
  rescue Exception => e
    logger.error "Error during grab process: #{e.message}"
    nil
  end

end

ActiveSupport.run_load_hooks(:grabber, self)
