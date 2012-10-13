class Releaser < ActiveRecord::Base

  ## included modules and attr_*

  attr_protected

  ## associations

  has_many :releases
  has_many :titles, through: :releases
  has_many :subscriptions
  has_many :users, through: :subscriptions, uniq: true

  ## scopes

  scope :with_name, ->(name){ where(name: name) }

  ## validations

  validates :name, uniqueness: true

end
