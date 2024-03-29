class Subscription < ActiveRecord::Base

  ## included modules and attr_*

  attr_accessible :title_id, :releaser_id

  ## associations

  belongs_to :user
  belongs_to :title
  belongs_to :releaser

  ## scopes

  reflections.values_at(:user, :title, :releaser).each do |r|
    scope "for_#{r.name}", ->(value) { where(r.foreign_key => value.is_a?(r.klass) ? value.id : value) }
  end

  scope :for_release, ->(release) { where("title_id = ? OR releaser_id = ?", release.title_id, release.releaser_id) }

  ## validations

  validates_presence_of :user_id

  # @note:
  # we should have at least one of [title, releaser]
  # and [title, releaser, user] should be unique
  validates_presence_of :releaser, unless: :title
  validates_presence_of :title,    unless: :releaser

  validates :title_id,    uniqueness: { scope: :user_id }, presence: true, unless: :releaser_id
  validates :releaser_id, uniqueness: { scope: [:user_id, :title_id] }, allow_nil: true

  ## public methods

  def full?
    releaser_id.present? && title_id.present?
  end

end
