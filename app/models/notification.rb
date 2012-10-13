class Notification

  def initialize(release)
    @release = release
  end

  def deliver_to(user)
    return true if delivered_to?(user.id) # already delivered
    UserMailer.delay.new_release(user, @release)
    add(user.id)
  end

  def delivered_to?(user_id)
    Rails.redis.sismember("release-#{@release.id}", user_id)
  end

  private

  def add(user_id)
    Rails.redis.sadd("release-#{@release.id}", user_id)
  end

end