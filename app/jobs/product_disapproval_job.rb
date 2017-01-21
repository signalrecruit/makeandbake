class ProductDisapprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, product)
    @user = user
    @product = product
    DisapproveProduct.product_disapproval(@user, @product).deliver_later
  end
end
