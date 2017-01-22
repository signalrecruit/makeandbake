class DisapproveProduct < ApplicationMailer

  default from: "MakeAndBake"
  layout "makeandbake"

  def product_disapproval(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: "Your product has been rejected!")    
  end
end
