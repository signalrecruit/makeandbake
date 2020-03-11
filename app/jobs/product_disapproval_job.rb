class ProductDisapprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, product)
    DisapproveProduct.product_disapproval(user, product).deliver_later
  end
end
