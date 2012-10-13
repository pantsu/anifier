class Title < ActiveRecord::Base
  attr_protected

  has_many :releasers
  has_many :subscriptions
  has_many :users, through: :subscriptions, uniq: true

  validates :name, uniqueness: true
end
