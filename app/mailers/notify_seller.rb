class NotifySeller < ApplicationMailer
  default from: "MakeAndBake"

  def seller_notification(order, seller)
  	@order = order
  	@seller = seller
  	mail(to: @seller.email, subject: "Someone is interested in your product")    
  end
end
