class UserDecorator < ApplicationDecorator

  def name
    model.email
  end

end