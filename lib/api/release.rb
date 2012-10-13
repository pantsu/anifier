module API
  Release = Struct.new(:raw, :releaser, :title, :episodes, :volume, :extension, :audio, :video, :media, :dimension, :crc32)

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
  end
end