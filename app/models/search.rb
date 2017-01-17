class Search < ActiveRecord::Base
  
  def search_products
    
    products = Product.where(approved: true).order(price: :asc).all

    products = products.where(["lower(name) LIKE ?", "%#{keywords.downcase}%"]) if keywords.present?
    # products = Product.where(["name LIKE ?", name]) if name.present?
    products = products.where(["price >= ?", min_price]) if min_price.present?
    products = products.where(["price <= ?", max_price]) if max_price.present?
    products = products.where(["lower(size) LIKE ?", "%#{size.downcase}%"]) if size.present?
    # products_by_tags = Product.joins(:tags).where(tags: { name: name })
    products = products.joins(:tags).where(tags: { name: "#{category.downcase}" }) if category.present?


    products
  end

   def admin_search_products
    
    products = Product.order(price: :asc).all

    products = products.where(["lower(name) LIKE ?", "%#{keywords.downcase}%"]) if keywords.present?
    products = products.where(["price >= ?", min_price]) if min_price.present?
    products = products.where(["price <= ?", max_price]) if max_price.present?
    products = products.where(["lower(size) LIKE ?", "%#{size.downcase}%"]) if size.present?
    # products_by_tags = Product.joins(:tags).where(tags: { name: name })
    products = products.joins(:tags).where(tags: { name: "#{category.downcase}" }) if category.present?


    products
  end
end
