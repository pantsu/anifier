class SubscriptionsController < ApplicationController

  def create

  end

  def destroy
    subscriptions = Subscription.for_user(current_user).where(id: params[:subscription_ids]).destroy_all
    redirect_to :back, notice: t('destroyed')
  end
end