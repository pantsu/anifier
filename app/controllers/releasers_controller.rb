class ReleasersController < ApplicationController
  load_resource

  def index
    @releasers = @releasers.recent.page(params[:page])
  end

  def show
    @releaser = @releaser.decorate
  end
end