class Search < ActiveRecord::Base
  
  def search_products
    
    products = Product.all

    products = products.where(["lower(name) LIKE ?", "%#{keywords.downcase}%"]) if keywords.present?
    # products = Product.where(["name LIKE ?", name]) if name.present?
    products = products.where(["price >= ?", min_price]) if min_price.present?
    products = products.where(["price <= ?", max_price]) if max_price.present?
    # products_by_tags = Product.joins(:tags).where(tags: { name: name })


    products
  end
end
