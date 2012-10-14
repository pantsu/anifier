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

  def construct
    @subscription = Subscription.new
    @subscription.user_id     = current_user.id
    @subscription.releaser_id = params[:releaser_id]
    @subscription.title_id    = params[:title_id]

    if !@subscription.full?
      redirect_to :back, notice: t("subscriptions.create.unprocessable")
    elsif @subscription.save
      redirect_to :back, notice: t("subscriptions.create.success")
    else
      redirect_to :back, alert: t("subscriptions.create.failure")
    end
  end

  def destroy
    @subscription.destroy
    render json: { success: true, notice: t("subscriptions.destroy.success") }
  end
end
