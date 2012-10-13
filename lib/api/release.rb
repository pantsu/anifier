module API
  RELEASE_ATTRIBUTES = [:raw, :releaser, :title, :episodes, :volume, :extension, :audio, :video, :media, :resolution, :crc32]
  Release = Struct.new(*RELEASE_ATTRIBUTES)

  class Release
    def self.build(raw, *elements)
      instance = new
      instance.raw = raw
      instance.append *elements
      instance
    end

    def append(*elements)
      elements.each do |e|
        next unless e.instance_of?(Treetop::Runtime::SyntaxNode)
        append *e.elements unless e.elements.nil?

        next unless content = (e.content rescue nil)
        self[content.first] = content.last
      end
      self
    end

    def to_hash
      Hash[*members.zip(values).flatten]
    end

    def valid?
      releaser.present? && title.present? && (episodes.present? || volume.present?)
    end
  end
end