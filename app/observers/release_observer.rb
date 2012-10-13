class ReleaseObserver < ActiveRecord::Observer
  observe :release

  def after_create(release)
    Subscription.for_title(release.title_id).for_releaser(release.releaser_id).find_each do |subscription|
      Notification.deliver(subscription.user_id, release.id)
    end
  end
end