# Preview all emails at http://localhost:3000/rails/mailers/order_notification
class OrderNotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_notification/notification_of_order
  def notification_of_order
    OrderNotification.notification_of_order
  end

end
