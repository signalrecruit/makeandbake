class InterestInClient < ApplicationMailer
  default from: "makeandbake"
 
  def establish_interest(order, seller)
   @order = order
   @seller = seller
   mail(to: @order.sender_email, subject: "Someone wants to sell you cakes.")
  end
end
