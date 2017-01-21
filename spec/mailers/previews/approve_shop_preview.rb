# Preview all emails at http://localhost:3000/rails/mailers/approve_shop
class ApproveShopPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/approve_shop/shop_approval
  def shop_approval
    ApproveShop.shop_approval
  end

end
