class Admin::ProductsController < Admin::ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :approve, :disapprove]
  before_action :set_shop, except: [:index, :remove, :user_products]
  before_action :set_user, only: [:user_products]

  def index
    # @products = Product.all.order(price: :asc)
    @products = Product.search(params[:search]).order(price: :asc).uniq
  end

  def show
  	display_related_products(@product)
  end

  def new
  	@product = @shop.products.new
  end

  def create
    # @user.update(seller: true) if !@user.seller?
    
  	@product = @shop.products.new(product_params)

    @product.tag_names = params[:product][:tag_names]
    
    if @product.save
        flash[:notice] = "Product was successfully created."
        redirect_to [:admin, @shop, @product]
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
      redirect_to [:admin, @shop, @product]
    else
      flash.now[:alert] = "product update failed"
      render "edit"
    end
  end

  def destroy
  	@product = @shop.products.find(params[:id])
    @product.destroy
    flash[:notice] = "product successfully removed."
    redirect_to admin_root_path
  end

  def remove
  	@product = Product.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    @product.tags.destroy(@tag)
    # redirect_to [:admin, @product.shop, @product]
    redirect_to :back
  end

  def user_products
    @user_products = @user.products
  end

  def approve
    @product.approve
    ProductApprovalJob.set(wait: 5.seconds).perform_later(@product.user, @product)
    flash[:notice] = "product approval successful"
    redirect_to :back
  end

  def disapprove
    @product.disapprove
    ProductDisapprovalJob.set(wait: 5.seconds).perform_later(@product.user, @product)
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

  def product_params
  	params.require(:product).permit(:name, :description, :price, 
      :imageone, :imageone_cache, :imagetwo, :imagetwo_cache, :imagethree, :imagethree_cache, :imagefour, :imagefour_cache,
       :tag_names, :size, :shop_id, :tag_ids => [])
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The shop you were looking for could not be found.."
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

  def set_user
    @user = User.find(params[:user_id])
rescue ActiveRecord::RecordNotFound
  flash[:alert] = " sorry, could not find the user record you are looking for"
  redirect_to admin_root_path
  end
end
