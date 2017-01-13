class Admin::ShoplessProductsController < Admin::ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :approve, :disapprove]	
  before_action :set_user, except: [:add]
  
  def index
    @shop = Shop.find(params[:shop_id])
    @shopless_products = Product.all.where(shop_id: nil, user_id: @user.id)
  end

  def show
    display_related_products(@product)
  end


  def new
    @product = @user.products.new
  end

  def create
    @user.update(seller: true) if !@user.seller?

    @product = @user.products.new(product_params)

    @product.tag_names = params[:product][:tag_names]

    if @product.save
      flash[:notice] = "Product was successfully created."
      redirect_to admin_user_shopless_product_path @user, @product
    else
      flash.now[:alert] = "Failed to create product"
      render "new"
    end 
  end

  def edit
  end

  def update
    @product.tag_names = params[:product][:tag_names]

    if @product.update(product_params)
      flash[:notice] = "product update successful"
      redirect_to admin_user_shopless_product_path @user, @product
    else
      flash.now[:alert] = "product update failed"
      render "edit"
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_root_path
  end

  def add
    @shop = Shop.find(params[:shop_id])

    @product = Product.find(params[:id])

    @product.update(shop_id: @shop.id)
    flash[:notice] = "product successfully added to shop"
    redirect_to @shop
  end

  def user_shopless_products
  end

  def remove
    @product = Product.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    @product.tags.destroy(@tag)
    redirect_to shopless_product_path @product
  end

  def approve
    @product.approve
    flash[:notice] = "product approval successful"
    redirect_to :back
  end

  def disapprove
    @product.disapprove
    flash[:alert] = "product disapproved"
    redirect_to :back
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

  def set_product
  	@product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	flash[:alert] = "The product you were looking for could not be found."
  	redirect_to root_path
  end

  def set_user
  	@user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "the user record could not be found"
    redirect_to admin_root_path  	
  end

  def product_params
  	params.require(:product).permit(:name, :description, :price, 
      :imageone, :imageone_cache, :imagetwo, :imagetwo_cache, :imagethree, :imagethree_cache, :imagefour, :imagefour_cache,
       :tag_names, :size, :shop_id, :tag_ids => [])
  end
end
