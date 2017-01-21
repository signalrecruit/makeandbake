class ShopCreated < ApplicationMailer
  default from: "MakeAndBake"

  def shop_notification(user, shop)
  	@user = user
  	@shop = shop
  	@url = "https://makeandbake.herokuapp.com"
  	mail(to: @user.email, subject: "Hi, you just created a shop")   
  end
end
