class Release < ActiveRecord::Base
  belongs_to :releaser
  belongs_to :title

  validates :raw, :title_id, :episode, presence: true
  validates :raw, uniqueness: true
end
