class Notification
  def self.deliver(user_id, release_id)
    unless exists?(release_id: release_id, user_id: user_id)
      UserMailer.delay.new_release(User.find(user_id), Release.find(release_id))
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
