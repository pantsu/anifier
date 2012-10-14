class SubscriptionsController < ApplicationController

  def create
    Release.find(params[:release_ids]).each do |release|
      Subscription.create(title_id: release.title_id, releaser_id: release.releaser_id) { |s| s.user_id = current_user.id }
    end
    redirect_to :back, notice: t('created')
  end

  def destroy
    subscriptions = Subscription.for_user(current_user).where(id: params[:subscription_ids]).destroy_all
    redirect_to :back, notice: t('destroyed')
  end
end