class ShopCreatedJob < ActiveJob::Base
  queue_as :default

  def perform(user, shop)
    ShopCreated.shop_notification(user, shop).deliver_later
  end
end
