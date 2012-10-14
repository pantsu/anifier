class DashboardController < ApplicationController

  RELEASE_LIMIT = 10

  def index
    @releasers     = Releaser.random.limit(20)
    @subscriptions = current_user.try(:subscriptions)
    @resolutions   = Release.uniq.pluck(:resolution).compact
    @releases = if %w(releaser_id title resolution q).any? { |p| params[p].present? }
        Search.new(params[:title] || params[:q], releaser_id: params[:releaser_id], resolution: params[:resolution], limit: RELEASE_LIMIT).results
      else
        Release.recent.limit(RELEASE_LIMIT)
      end
  end
end
