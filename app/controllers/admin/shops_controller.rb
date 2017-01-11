class Admin::ShopsController < Admin::ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :set_user, except: [:index, :show]

  def index
  	@shops = Shop.all
  end

  def show
  	@shop_products = @shop.products.all.order(price: :asc)
  end

  def new
  	@shop = @user.shops.new
  end

  def create
  	@shop = @user.shops.new(shop_params)

  	if @shop.save
  	  flash[:notice] = "Your shop was created successfully!"
  	  redirect_to [:admin, @user, @shop]
  	else
  	  flash.now[:alert] = "Failed to create shop"
  	  render "new"
  	end
  end

  def edit
  end

  def update
  	if @shop.update(shop_params)
  	  flash[:notice] = "Your shop was successfully updated!"
  	  redirect_to [:admin, @user, @shop]
  	else
  	  flash.now[:alert] = "Your failed to update your shop"
  	  render "edit"
  	end
  end

  def destroy
  	@shop.destroy
  	flash[:notice] = "shop record destroyed successfully!"
  	redirect_to admin_shops_path
  end

  def user_shop
  end

  
  private

  def shop_params
  	params.require(:shop).permit(:name, :description, :location, :opening, :closing, :image, :user_id)
  end

  def set_shop
  	@shop = Shop.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "sorry, could not find the shop record you are looking for."
    redirect_to admin_root_path
  end

  def set_user
    @user = User.find(params[:user_id])
rescue ActiveRecord::RecordNotFound
	flash[:alert] = " sorry, could not find the user record you are looking for"
	redirect_to admin_root_path
  end
end
