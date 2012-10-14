class SubscriptionsController < ApplicationController
  load_resource

  def create
    @subscription.user_id = current_user.id
    if @subscription.save
      render json: { success: true, message: t("subscriptions.create.success") }
    else
      render json: { success: false, message: t("subscriptions.create.failure") }
    end
  end

  def destroy
    @subscription.destroy
    render json: { success: true, notice: t("subscriptions.destroy.success") }
  end
end