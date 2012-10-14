class DashboardController < ApplicationController
  def index
    @releasers = Releaser.random.limit(20)
    @releases  = Release.recent.limit(10)
  end
end
