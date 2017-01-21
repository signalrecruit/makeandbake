class ShopDisapprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, shop)
  	@user = user
  	@shop = shop
    DisapproveShop.shop_disapproval(@user, @shop).deliver_later
  end
end
