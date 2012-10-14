class SubscriptionsController < ApplicationController
  load_resource

  def create
    @subscription.user_id = current_user.id
    @subscription.title_id = params[:title_id]
    @subscription.releaser_id = params[:releaser_id]
    if @subscription.save
      render json: { success: true, message: t('created'), url: subscription_path(@subscription) }
    else
      render json: { success: false, message: t('failure_on_create') }, status: :unprocessable_entity
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

  def index
    render partial: 'shared/subscriptions', locals: { subscriptions: current_user.try(:subscriptions) }
  end

  def destroy
    @subscription.destroy
    render json: { success: true, notice: t('destroyed'), url: subscriptions_path }
  end
end
