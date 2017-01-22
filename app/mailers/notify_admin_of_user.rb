class NotifyAdminOfUser < ApplicationMailer
  default from: "MakeAndBake"
  layout "makeandbake"
  
  def notify_admin_of_signup(admin, user)
  	@admin = admin
  	@user = user
  	mail(to: @admin.email, subject: "A User Just Signed Up") 
  end
end
