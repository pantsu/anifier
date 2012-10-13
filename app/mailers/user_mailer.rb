class UserMailer < ActionMailer::Base
  default from: "donotreply@anifier.net"

  def new_release(user, release)
    @release = release
    mail to: user.email, subject: "Anifier: New release of #{@release.title_name} by #{@release.releaser_name}"
  end
end
