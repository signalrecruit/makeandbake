# Preview all emails at http://localhost:3000/rails/mailers/shop_created
class ShopCreatedPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/shop_created/shop_notification
  def shop_notification
    ShopCreated.shop_notification
  end

end
