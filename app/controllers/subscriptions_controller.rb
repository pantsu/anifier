class SubscriptionsController < ApplicationController

  def create
    Subscription.create_from_release_ids(params[:release_ids], current_user.id)
    redirect_to :back, notice: t('created')
  end

  def destroy
    Subscription.destroy_for_user(params[:subscription_ids], current_user.id)
    redirect_to :back, notice: t('destroyed')
  end
end