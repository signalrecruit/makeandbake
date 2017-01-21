# Preview all emails at http://localhost:3000/rails/mailers/approve_product
class ApproveProductPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/approve_product/product_approval
  def product_approval
    ApproveProduct.product_approval
  end

end
