class SubscriptionsController < ApplicationController

  def create
    %w(release_ids title_ids releaser_ids).each do |key|
      Subscription.create_for(params[key], key.to_sym, current_user.id) if params[key]
    end
    redirect_to :back, notice: t('created')
  end

  def destroy
    Subscription.destroy_for_user(params[:subscription_ids], current_user.id)
    redirect_to :back, notice: t('destroyed')
  end
end