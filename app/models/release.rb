class Release < ActiveRecord::Base
  attr_protected

  belongs_to :releaser
  belongs_to :title

  validates :raw, :title_id, :releaser_id, :episodes, presence: true
  validates :raw, uniqueness: true
  validates :title_id, uniqueness: { scope: :releaser_id }

  define_index :releases do
    indexes title(:name), as: :title, sortable: true
    indexes media

    has "crc32(audio)", as: :audio, type: :integer
    has "crc32(video)", as: :video, type: :integer

    has releaser_id
    has created_at

    set_property delta: true
  end

  def self.from_feed(url)
    API::Grabber.new(url).releases.each { |data| import(data) }
  end

  def self.import(data)
    attributes = columns_hash.keys
    create do |release|
      data.to_hash.each do |k,v|
        if k.to_s.in?(attributes)
          release[k] = v
        elsif (key = k.to_s.foreign_key).in?(attributes)
          release[key] = k.to_s.classify.constantize.with_name(v).first_or_create.id
        else
          raise ActiveRecord::UnknownAttributeError, "Unknown attribute: #{k.inspect}"
        end
      end
    end
  end

end
