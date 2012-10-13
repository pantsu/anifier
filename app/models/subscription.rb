class Subscription < ActiveRecord::Base

  ## included modules and attr_*

  attr_accessible :title_id, :releaser_id

  ## associations

  belongs_to :user
  belongs_to :title
  belongs_to :releaser

  ## scopes

  reflections.values_at(:user, :title, :releaser).each do |r|
    scope "for_#{r.name}", ->(value){ where(r.foreign_key => value.is_a?(r.klass) ? value.id : value) }
  end

  ## validations

  validates :user_id, :title_id, presence: true
  validates :title_id, uniqueness: { scope: :user_id }, unless: :releaser_id
  validates :releaser_id, uniqueness: { scope: [:user_id, :title_id] }, allow_nil: true

end
