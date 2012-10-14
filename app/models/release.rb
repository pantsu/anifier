class Release < ActiveRecord::Base

  ## consnants

  SEARCH_ATTRIBUTES = [:resolution, :audio, :video]

  ## included modules and attr_*

  attr_protected

  ## associations

  belongs_to :releaser
  belongs_to :title

  ## scopes

  scope :recent, order('created_at DESC')

  ## plugins

  define_index :releases do
    indexes title(:name), as: :title, sortable: true
    indexes media

    SEARCH_ATTRIBUTES.each { |field| has "crc32(#{field})", as: field, type: :integer }

    has releaser_id
    has created_at

    set_property delta: true
  end

  ## sphinx scopes

  sphinx_scope(:by_relevance)  {{:order => '@relevance ASC'}}

  sphinx_scope(:by_phrase)     {{:match_mode => :phrase}}
  sphinx_scope(:by_all_words)  {{:match_mode => :all}}
  sphinx_scope(:by_any_word)   {{:match_mode => :any}}

  SEARCH_ATTRIBUTES.each do |field|
    sphinx_scope(:"with_#{field}") { |value| {:with => {field => value.to_s.downcase.to_crc32}}}
  end

  ## validations

  validates :raw, :title_id, :releaser_id, :episodes, presence: true
  validates :raw, uniqueness: true
  validates :title_id, uniqueness: { scope: :releaser_id }

  ## class-methods

  delegate :name, to: :title, prefix: true
  delegate :name, to: :releaser, prefix: true

  def self.resolutions
    # @todo: cache and reload on import
    self.uniq.pluck(:resolution).compact
  end

  def self.from_feed(url)
    API::Grabber.new(url).releases.each { |data| import(data) }
  end

  def self.import(data)
    create do |release|
      data.to_hash.each do |k,v|
        if columns_hash.key?(k.to_s)
          release[k] = v
        elsif r = reflections[k]
          release[r.foreign_key] = r.klass.with_name(v).first_or_create.id
        else
          raise ActiveRecord::UnknownAttributeError, "Unknown attribute: #{k.inspect}"
        end
      end
    end
  rescue ActiveRecord::RecordNotUnique
    false
  end

end
