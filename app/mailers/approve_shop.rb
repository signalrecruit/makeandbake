class ApproveShop < ApplicationMailer
  default from: "MakeAndBake"
  layout "makeandbake"
  
  def shop_approval(user, shop)
    @user = user
    @shop = shop
    mail(to: @user.email, subject: "Your Shop has been approved!")
  end
end
