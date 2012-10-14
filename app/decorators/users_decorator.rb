class UsersDecorator < ApplicationDecorator

  def name
    model.email
  end

end