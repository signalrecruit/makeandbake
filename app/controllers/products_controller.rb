class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
  	@products = Product.all
  end

  def show
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(product_params)

  	if @product.save
  	  flash[:notice] = "Product was successfully created."
  	  redirect_to @product
  	else
  	  flash.now[:alert] = "Failed to create product"
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

  def product_params
  	params.require(:product).permit(:name, :description, :price)
  end

  def set_product
  	@product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	flash[:alert] = "The product you were looking for could not be found."
  	redirect_to root_path
  end
end
