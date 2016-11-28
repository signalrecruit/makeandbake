class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
  end

  def show
  end

  def new
  end

  def create
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
