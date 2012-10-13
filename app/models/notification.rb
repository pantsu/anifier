class Notification
  def self.deliver(user, release)
    unless Notification.for_user(user).for_release(release).exists?
      UserMailer.delay.new_release(user, release)
      user_id    = user.is_a?(User) ? user.id : user
      release_id = release.is_a?(Release) ? release.id : release
      create(user_id: user_id, release_id: release_id)
    end
  end
end
