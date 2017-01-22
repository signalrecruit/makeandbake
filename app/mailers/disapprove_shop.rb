class DisapproveShop < ApplicationMailer
 default from: "MakeAndBake"
 # layout "makeandbake"
  
  def shop_disapproval(user, shop)
    @user = user
    @shop = shop 
    mail(to: @user.email, subject: "Your Shop has been rejected!")
  end
end
