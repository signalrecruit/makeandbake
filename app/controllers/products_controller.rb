class ProductsController < ApplicationController
  before_action :set_shop, except: [:index, :my_products, :categorization, :show, :remove]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
 

  def index
  	@products = Product.search(params[:search]).order(price: :asc)
  end

  def show
   display_related_products(@product)
  end

  def new
    @product = @shop.products.build
  end

  def create
    current_user.update(seller: true) if !current_user.seller?

      @product = @shop.products.new(product_params)
      @product.user_id = current_user.id

      @product.tag_names = params[:product][:tag_names]

      if @product.save
        flash[:notice] = "Product was successfully created."
        redirect_to [@shop, @product]
      else
        flash.now[:alert] = "Failed to create product"
        render "new"
      end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "product update successful"
      redirect_to [@shop, @product]
    else
      flash.now[:alert] = "product update failed"
      render "edit"
    end
  end

  def destroy
    @product = @shop.products.find(params[:id])
    @product.destroy
    flash[:notice] = "product successfully removed."
    redirect_to products_path
  end

  def my_products
    @products = []
    if current_user && current_user.shops.any?
      @shops = current_user.shops
      @shops.each do |shop|
        shop.products.each do |product|
          @products << product
        end
      end
      @products
    elsif current_user && current_user.products.where(shop_id: nil).any?
      @products = current_user.products.where(shop_id: nil).order(created_at: :asc)
    end
  end

  def categorization
    @products = Product.joins(:tags).where(tags: { name: params[:category].downcase })
  end

  def remove
    @product = Product.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    @product.tags.destroy(@tag)
    redirect_to product_path @product
  end

 
  private

  def display_related_products(product)
    @products_array = []
    @products = []
   
    @product.tag_ids.each do |tag|
      @products_array << Product.includes(:tags).where(tags: {name: Tag.find(tag).name})
    end
   
    @products1 = Array(@products_array)

    @products1.each do |products|
      products.each do |product|
        @products << product
      end
    end
    @products = @products.uniq
  end

  def product_params
  	params.require(:product).permit(:name, :description, :price, 
      :imageone, :imageone_cache, :imagetwo, :imagetwo_cache, :imagethree, :imagethree_cache, :imagefour, :imagefour_cache,
       :tag_names, :size, :shop_id, :tag_ids => [])
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The shop you were looking for could not be found."
    redirect_to root_path
  end

  def set_product
    if @shop
      begin
        @product = @shop.products.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The product you were looking for could not be found."
        redirect_to root_path
      end
    else
      begin
  	    @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
  	    flash[:alert] = "The product you were looking for could not be found."
  	    redirect_to root_path
      end
    end
  end
end
