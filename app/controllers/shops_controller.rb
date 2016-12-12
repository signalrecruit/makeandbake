class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  

  def index
  end
  
  def show
  end

  def new
  	@shop = Shop.new
  end

  def create
  	current_user.update(seller: true) if !current_user.seller?

  	@shop = current_user.shops.new(shop_params)

  	if @shop.save
  	  flash[:notice] = "Your shop was created successfully!"
  	  redirect_to new_product_path
  	else
  	  flash.now[:alert] = "Failed to create shop"
  	  render "new"
  	end

  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def shop_params
  	params.require(:shop).permit(:name, :description, :email, :phonenumber, :location, :opening, :closing, :image)
  end

  def set_shop
  	@shop = Shop.find(params[:id])
  end
end
