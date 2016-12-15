class ShoplessProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :add]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
 

  def index
    @shop = Shop.find(params[:shop_id])
    @shopless_products = Product.all.where(shop_id: nil)
  end
  
  def show
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = current_user.products.new(product_params)

    if @product.save
      flash[:notice] = "Product was successfully created."
      redirect_to shopless_product_path(@product)
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
      redirect_to shopless_product_path(@product)
    else
      flash.now[:alert] = "product update failed"
      render "edit"
    end
  end

  def destroy
  	@product.destroy
  	redirect_to products_path
  end

  def add
    @shop = Shop.find(params[:shop_id])

    @product.update(shop_id: @shop.id)
    redirect_to @shop
  end
  

  private


  def set_product
  	@product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	flash[:alert] = "The product you were looking for could not be found."
  	redirect_to root_path
  end

  def product_params
  	params.require(:product).permit(:name, :description, :price, 
      :imageone, :imageone_cache, :imagetwo, :imagetwo_cache, :imagethree, :imagethree_cache, :imagefour, :imagefour_cache,
       :tag_names, :shop_id)
  end
end
