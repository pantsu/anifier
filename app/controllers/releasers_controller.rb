class ReleasersController < ApplicationController

  load_resource

  def index
    @releasers = Releaser.order(:name)
    # @releasers = @releasers.recent.page(params[:page])
  end
end
