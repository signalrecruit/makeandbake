class Admin::OrdersController < Admin::ApplicationController
  before_action :set_order, only: [:show]
  
  def index
    @orders = Order.all
  end

  def show
  end


  private

  def set_order
  	@order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	flash[:alert] = "order record not found"
  	redirect_to :back
  end

  def order_params
  	params.require(:order).permit(:description, :min_price, :max_price, :size,
  		:recipient_address, :recipient_name, :recipient_email, :recipient_phonenumber,
  		:sample_picture, :delivery_date, :sender_name, :sender_email, :sender_phonenumber,
  		 :sender_address)
  end
end
