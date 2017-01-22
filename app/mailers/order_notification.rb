class OrderNotification < ApplicationMailer
  default from: "MakeAndBake"
  layout "makeandbake"

  def notification_of_order(admin, order)
    @admin = admin
    @order = order
    @url = "https://makeandbake.herokuapp.com"
    mail(to: @admin.email, subject: "Cake Order Placement")
  end
end
