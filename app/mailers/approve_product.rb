class ApproveProduct < ApplicationMailer

  default from: "MakeAndBake"

  def product_approval(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: "your product has been approved")
  end
end
