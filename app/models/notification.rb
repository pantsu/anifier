class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :release

  validates :user_id, uniqueness: { scope: [:release_id] }

  key_attr_scope :user, :release
end
