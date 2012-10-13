class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :title
  belongs_to :releaser
  belongs_to :release

  validates :user_id, uniqueness: { scope: [:title_id, :releaser_id, :release_id] }
end
