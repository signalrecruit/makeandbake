class Admin::SearchesController < Admin::ApplicationController
  
  def show
  	@search = Search.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Oops! search result failed for some reason"
    render "new"
  end

  def new
  	@search = Search.new
  	# @product_categories = Tag.uniq.pluck(:name)
  end

  def create
  	@search = Search.create(search_params)
  	redirect_to [:admin, @search]
  end

  

  private

  def search_params
  	params.require(:search).permit(:keywords, :name, :max_price, :min_price, :size, :category)
  end
end
