class Search

  ORDER_MODES = %w( by_relevance )
  MATCH_MODES = %w( by_phrase by_all_words by_any_word )

  ## included modules and attr_*

  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Draped

  attr_reader :query, :order_mode, :match_mode, :resolution, :audio, :video

  ## validations

  validates_presence_of     :query
  validates_inclusion_of    :order_mode,  in: ORDER_MODES, allow_nil: true
  validates_inclusion_of    :match_mode,  in: MATCH_MODES, allow_nil: true

  ## class-methods

  delegate :current_page, :total_pages, :total_entries, :query_time, to: :results, allow_nil: true

  def initialize(query, options = {})
    @page, @limit = 1, 100
    @query = query
    options.assert_valid_keys(:order_mode, :match_mode, :resolution, :audio, :video)
    options.each { |name, value| instance_variable_set :"@#{name}", value }
  end

  public

  def results
    @results ||= valid? ? scoped.search(query).page(@page).per(@limit) : []
  end

  def scoped
    @scoped ||= begin
      scoped = Release
      scoped = scoped.send(order_mode) if order_mode.present?
      scoped = scoped.send(match_mode) if match_mode.present?
      scoped = scoped.with_resolution(resolution) if resolution.present?
      scoped = scoped.with_audio(audio) if audio.present?
      scoped = scoped.with_video(video) if video.present?
      scoped
    end
  end

  # kaminari support
  def per(limit)
    @limit = limit.to_i
    self
  end

  # kaminari support
  def page(number)
    @page = number.to_i
    self
  end

  def persisted?
    true
  end

end