class Title < ActiveRecord::Base
  has_many :releasers
  has_many :subscriptions
  has_many :users, through: :subscriptions, uniq: true
end
