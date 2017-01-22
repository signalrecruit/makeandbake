class NotifyAdminOfShopCreation < ApplicationMailer

  default from: "makeandbake"
  # layout "makeandbake"

  def admin_notification(admin, shop)
  	@admin = admin
  	@shop = shop
  	mail(to: @admin.email, subject: "a user just created a shop")    
  end
end
