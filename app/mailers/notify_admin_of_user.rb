class NotifyAdminOfUser < ApplicationMailer
  default from: "MakeAndBake"

  def notify_admin_of_signup(admin, user)
  	@admin = admin
  	@user = user
  	mail(to: @admin.email, subject: "A User Just Signed Up") 
  end
end
