class Notification
  def self.deliver(user_id, release_id)
    unless exists?(release_id, user_id)
      UserMailer.delay.new_release(User.find(user_id), Release.find(release_id))
      add(release_id, user_id)
    end
  end

  private

  def self.exists?(release_id, user_id)
    Rails.redis.sismember("release-#{release_id}", user_id)
  end

  def self.add(release_id, user_id)
    Rails.redis.sadd("release-#{release_id}", user_id)
  end
end
