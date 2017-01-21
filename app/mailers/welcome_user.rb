class WelcomeUser < ApplicationMailer
  default from: "MakeAndBake"

  def welcome_email(user, admin)
  	@user = user
  	@admin = admin
  	@url = "https://makeandbake.herokuapp.com"
  	mail(to: @user.email, subject: "Welcome to MakeAndBake")
  end
end
