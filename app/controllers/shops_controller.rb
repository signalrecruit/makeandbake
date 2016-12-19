class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @shops = Shop.all.order(created_at: :asc)
  end
  
  def show
  	@shop_products = @shop.products.all.order(price: :asc)
  end

  def new
  	@shop = Shop.new
  end

  def create
  	current_user.update(seller: true) if !current_user.seller?

  	@shop = current_user.shops.new(shop_params)

  	if @shop.save
  	  flash[:notice] = "Your shop was created successfully!"
  	  redirect_to @shop
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
  	  redirect_to @shop
  	else
  	  flash.now[:alert] = "Your failed to update your shop"
  	  render "edit"
  	end
  end

  def destroy
  	@shop.destroy
  	flash[:alert] = "do you want to remove this shop? Removing this shop will delete all associated products!"
  	redirect_to new_shop_path
  end

  def my_shops
  	@shops = current_user.shops.all.order(created_at: :asc) if current_user 
  end


  private

  def shop_params
  	params.require(:shop).permit(:name, :description, :location, :opening, :closing, :image, :user_id)
  end

  def set_shop
  	@shop = Shop.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "sorry, could not find the record you are looking for."
    redirect_to root_path
  end
end
