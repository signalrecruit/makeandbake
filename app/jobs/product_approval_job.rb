class ProductApprovalJob < ActiveJob::Base
  queue_as :default

  def perform(user, product)
    @user = user
    @product = product
    ApproveProduct.product_approval(@user, @product).deliver_later
  end
end
