class ShopApprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, shop)
    ApproveShop.shop_approval(user, shop).deliver_later  
  end
end
