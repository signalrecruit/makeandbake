class WelcomeUser < ApplicationMailer
  default from: "MakeAndBake"
  layout "makeandbake"

  def welcome_email(user)
  	@user = user
  	@url = "https://makeandbake.herokuapp.com"
  	mail(to: @user.email, subject: "Welcome to MakeAndBake")
  end
end
