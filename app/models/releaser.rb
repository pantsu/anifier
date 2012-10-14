class Releaser < ActiveRecord::Base

  ## included modules and attr_*

  attr_protected

  ## associations

  has_many :releases, dependent: :delete_all
  has_many :titles, through: :releases
  has_many :subscriptions, dependent: :delete_all
  has_many :users, through: :subscriptions, uniq: true

  ## scopes

  scope :with_name, ->(name){ where(name: name) }
  scope :random, order('random()')
  scope :recent, order('created_at DESC')

  ## validations

  validates :name, uniqueness: true

end
