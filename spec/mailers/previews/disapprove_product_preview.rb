# Preview all emails at http://localhost:3000/rails/mailers/disapprove_product
class DisapproveProductPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/disapprove_product/product_disapproval
  def product_disapproval
    DisapproveProduct.product_disapproval
  end

end
