class Releaser < ActiveRecord::Base
  has_many :releases
  has_many :titles, through: :releases
  has_many :subscriptions
  has_many :users, through: :subscriptions, uniq: true

  validates :name, presence: true
end
