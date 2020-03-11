class ShopDisapprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, shop)
    DisapproveShop.shop_disapproval(user, shop).deliver_later
  end
end
