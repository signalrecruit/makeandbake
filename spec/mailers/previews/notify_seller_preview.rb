# Preview all emails at http://localhost:3000/rails/mailers/notify_seller
class NotifySellerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notify_seller/seller_notification
  def seller_notification
    NotifySeller.seller_notification
  end

end
