class Search < ActiveRecord::Base
  
  def search_products
    
    products = Product.all

    products = Product.where(["lower(name) LIKE ?", "%#{keywords.downcase}%"]) if keywords.present?
    # products = Product.where(["name LIKE ?", name]) if name.present?
    products = Product.joins(:tags).where(tags: { name: name })
    products = Product.where(["price >= ?", min_price]) if min_price.present?
    products = Product.where(["price <= ?", max_price]) if max_price.present?

    products
  end
end
