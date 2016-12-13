class ProductsController < ApplicationController
  before_action :set_shop, except: [:index]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
 

  def index
  	@products = Product.search(params[:search]).order(price: :asc)
  end

  def show
  end

  def new
    if set_shop
      @product = @shop.products.build
    else  
  	  @product = Product.new
    end
  end

  def create
    current_user.update(seller: true) if !current_user.seller?

    if set_shop
      @product = @shop.products.new(product_params)

      if @product.save
        flash[:notice] = "Product was successfully created."
        redirect_to [@shop, @product]
      else
        flash.now[:alert] = "Failed to create product"
        render "new"
      end


    elsif 

      @product = current_user.products.new(product_params)

      if @product.save
        flash[:notice] = "Product was successfully created."
        redirect_to @product
      else
        flash.now[:alert] = "Failed to create product"
        render "new"
      end  

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
    redirect_to products_path
  end

  private

  def product_params
  	params.require(:product).permit(:name, :description, :price, 
      :imageone, :imageone_cache, :imagetwo, :imagetwo_cache, :imagethree, :imagethree_cache, :imagefour, :imagefour_cache,
       :tag_names, :shop_id)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The record you were looking for could not be found."
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
