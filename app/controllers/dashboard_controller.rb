class DashboardController < ApplicationController

  RELEASE_LIMIT = 10

  def index
    @releasers     = Releaser.all
    @releases      = Release.recent.limit(10)
    @subscriptions = current_user.try(:subscriptions)
    @resolutions   = Release.uniq.pluck(:resolution).compact
    @releases = if params[:q].present?
        Search.new(params[:q], limit: RELEASE_LIMIT).results
      else
        Release.recent.limit(RELEASE_LIMIT)
      end
  end
end
