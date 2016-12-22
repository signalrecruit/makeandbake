class SearchesController < ApplicationController

  def show
  	@search = Search.find(params[:id])
  end

  def new
  	@search = Search.new
  	@product_categories = Tag.uniq.pluck(:name)
  end

  def create
  	@search = Search.create(search_params)
  	redirect_to @search 
  end

  private

  def search_params
  	params.require(:search).permit(:keywords, :name, :max_price, :min_price, :size, :category)
  end
end
