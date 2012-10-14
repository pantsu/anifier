class ReleasersController < ApplicationController

  load_resource

  def index
    @releasers = Releaser.order(:name)
    # @releasers = @releasers.recent.page(params[:page])
  end

  def show
    @releaser = @releaser.decorate
    @subscriptions = current_user.subscriptions.for_releaser(@releaser) if user_signed_in?
  end
end
