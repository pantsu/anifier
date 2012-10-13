class Notification < ActiveRecord::Base
  attr_protected

  belongs_to :user
  belongs_to :release

  validates :user_id, uniqueness: { scope: [:release_id] }

  key_attr_scope :user, :release

  def self.deliver(user, release)
    unless Notification.for_user(user).for_release(release).exists?
      UserMailer.delay.new_release(user, release)
      user_id    = user.is_a?(User) ? user.id : user
      release_id = release.is_a?(Release) ? release.id : release
      create(user_id: user_id, release_id: release_id)
    end
  end
end
