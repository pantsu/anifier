class Subscription < ActiveRecord::Base
  attr_accessible :title_id, :releaser_id

  belongs_to :user
  belongs_to :title
  belongs_to :releaser

  validates :user_id, :title_id, presence: true
  validates :title_id, uniqueness: { scope: :user_id }, if: ->(obj){ obj[:releaser_id].nil? }
  validates :releaser_id, uniqueness: { scope: [:user_id, :title_id] }, allow_nil: true
end
