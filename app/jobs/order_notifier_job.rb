class OrderNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(admin, order)
    OrderNotification.notification_of_order(admin, order).deliver_later
  end
end
