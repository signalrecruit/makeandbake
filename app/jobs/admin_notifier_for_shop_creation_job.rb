class AdminNotifierForShopCreationJob < ActiveJob::Base
  queue_as :default

  def perform(admin, shop)
  	NotifyAdminOfShopCreation.admin_notification(admin, shop).deliver_later
  end
end
