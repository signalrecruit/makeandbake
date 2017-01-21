# Preview all emails at http://localhost:3000/rails/mailers/disapprove_shop
class DisapproveShopPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/disapprove_shop/shop_disapproval
  def shop_disapproval
    DisapproveShop.shop_disapproval
  end

end
