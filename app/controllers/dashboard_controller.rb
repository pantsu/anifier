class DashboardController < ApplicationController
  def index
    @releasers     = Releaser.random.limit(20)
    @releases      = Release.recent.limit(10)
    @subscriptions = current_user.try(:subscriptions)
    @resolutions   = Release.uniq.pluck(:resolution).compact
  end
end
