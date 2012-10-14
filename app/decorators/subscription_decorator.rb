class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def full_title
    model.title.name.tap do |result|
      result << ' ' << model.releaser.name if model.releaser
      result << ' ' << h.l(model.created_at, format: :short)
    end
  end
end