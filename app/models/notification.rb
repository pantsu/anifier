class Notification
  def self.deliver(user_id, release_id)
    unless Notification.exists?(release_id: release_id, user_id: user_id)
      UserMailer.delay.new_release(user, release)
      user_id    = user.is_a?(User) ? user.id : user
      release_id = release.is_a?(Release) ? release.id : release
      add(user_id: user_id, release_id: release_id)
    end
  end

  private

  def self.exists?(args)
    Rails.redis.sismember(args[:release_id], args[:user_id])
  end

  def self.add(args)
    Rails.redis.sadd(args[:release_id], args[:user_id])
  end
end
