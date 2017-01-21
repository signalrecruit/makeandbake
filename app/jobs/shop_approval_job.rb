class ShopApprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, shop)
    @user = user
    @shop = shop
    ApproveShop.shop_approval(@user, @shop).deliver_later  
  end
end
