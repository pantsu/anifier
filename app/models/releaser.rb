class Releaser < ActiveRecord::Base
  attr_protected

  has_many :releases
  has_many :titles, through: :releases
  has_many :subscriptions
  has_many :users, through: :subscriptions, uniq: true

  validates :name, uniqueness: true

  scope :with_name, ->(name){ where(name: name) }
end
