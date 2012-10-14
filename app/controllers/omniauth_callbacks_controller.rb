class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def common
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user, notice: t('devise.signed_in')
    else
      redirect_to new_user_registration_url
    end
  end

  def twitter
  end

  alias_method :facebook, :common
  alias_method :github, :common
end
