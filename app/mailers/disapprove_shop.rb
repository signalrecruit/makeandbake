class DisapproveShop < ApplicationMailer
 default from: "MakeAndBake"
  
  def shop_disapproval(user, shop)
    @user = user
    @shop = shop 
    mail(to: @user.email, subject: "Your Shop has been rejected!")
  end
end
