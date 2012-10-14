class SubscriptionsController < ApplicationController
  load_resource

  def create
    @subscription.user_id = current_user.id
    if @subscription.save
      render json: { success: true, message: t('created') }
    else
      render json: { success: false, message: t('failure_on_create') }
    end
  end

  def destroy
    @subscription.destroy
    render json: { success: true, notice: t('destroyed') }
  end
end