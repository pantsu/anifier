class Release < ActiveRecord::Base

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

    has "crc32(audio)", as: :audio, type: :integer
    has "crc32(video)", as: :video, type: :integer

    has releaser_id
    has created_at

    set_property delta: true
  end

  ## sphinx scopes

  sphinx_scope(:by_relevance)  {{:order => '@relevance DESC'}}

  sphinx_scope(:by_phrase)     {{:match_mode => :phrase}}
  sphinx_scope(:by_all_words)  {{:match_mode => :all}}
  sphinx_scope(:by_any_word)   {{:match_mode => :any}}

  sphinx_scope(:with_audio)    { |audio| {:with => {:audio => audio.to_s.downcase.to_crc32}}}
  sphinx_scope(:with_video)    { |video| {:with => {:video => video.to_s.downcase.to_crc32}}}

  ## validations

  validates :raw, :title_id, :releaser_id, :episodes, presence: true
  validates :raw, uniqueness: true
  validates :title_id, uniqueness: { scope: :releaser_id }

  ## class-methods

  delegate :name, to: :title, prefix: true
  delegate :name, to: :releaser, prefix: true

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
  # @todo: handle pg exception
  rescue ActiveRecord::RecordNotUnique
  end

end
