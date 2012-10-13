class Release < ActiveRecord::Base
  attr_protected

  belongs_to :releaser
  belongs_to :title

  validates :raw, :title_id, :episodes, presence: true
  validates :raw, uniqueness: true

  define_index :releases do
    indexes audio, video, media
    indexes title(:name), as: :title, sortable: true
    set_property delta: true
    has releaser_id, created_at
  end

  def self.from_feed(url)
    API::Grabber.new(url).releases.each { |release_data| create_from_parsed_data(release_data.to_hash) }
  end

  def self.create_from_parsed_data(hash)
    attributes = columns_hash.keys
    create do |release|
      hash.each do |k, v|
        if k.to_s.in?(attributes)
          release[k] = v
        elsif "#{k}_id".in?(attributes)
          release["#{k}_id"] = k.to_s.classify.constantize.first_or_create(name: v).id
        else
          raise ActiveRecord::UnknownAttributeError, "Unknown attribute: #{k}"
        end
      end
    end
  end

end
