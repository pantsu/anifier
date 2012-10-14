class ReleaseObserver < ActiveRecord::Observer
  observe :release

  def after_create(release)
    # @todo: just select distinct user_id
    Subscription.for_release(release).find_each do |subscription|
      Notification.new(release).deliver_to(subscription.user)
    end
  end
end