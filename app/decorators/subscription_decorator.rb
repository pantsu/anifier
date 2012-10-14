class SubscriptionDecorator < ApplicationDecorator
  decorates :subscription

  def full_title
    result = []
    result << "[#{model.releaser.name}]" if model.releaser
    result << model.title.name if model.title
    # result << h.l(model.created_at, format: :short)
    result.join(' ')
  end
end
