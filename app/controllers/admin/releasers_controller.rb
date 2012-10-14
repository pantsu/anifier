class Admin::ReleasersController < Admin::BaseController

  load_and_authorize_resource

  def index
    @releasers = @releasers.recent.page(params[:page])
  end

  def edit
    @releaser = @releaser.decorate
  end

  def update
    if @releaser.update_attributes(params[:releaser])
      redirect_to admin_releasers_path, notice: t('admin.releasers.updated')
    else
      render action: :edit
    end
  end

  def destroy
    @releaser.destroy
    redirect_to admin_releasers_path, notice: t('admin.releasers.destroyed')
  end
end