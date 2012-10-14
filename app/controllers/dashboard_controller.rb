class DashboardController < ApplicationController
  def index
    @releasers  = Releaser.order('random()').limit(20)
    @releases = Release.order('created_at DESC').limit(10)
  end
end
