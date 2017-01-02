class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :show, :update, :destroy]

  def index
  end

  def show
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = current_user.orders.new(order_params)

  	if @order.save
  	  flash[:notice] = "Your order was placed successfully!"
  	  redirect_to @order
  	else
  	  flash[:alert] = "Your order wasn't placed!"
  	  render "new"
  	end
  end

  def edit
  end

  def update
  	if @order.update(order_params)
  	  flash[:notice] = "Your order was updated successfully!"
  	  redirect_to @order
  	else
  	  flash[:alert] = "Your order failed to update!"
  	  render "edit"
  	end
  end
  
  def destroy
  	@order.destroy
    flash[:notice] = "Your order was successfully deleted!"
  	redirect_to new_order_path
  end


  private

  def set_order
  	@order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The order you are looking for could not be found"
  	redirect_to root_path
  end

  def order_params
  	params.require(:order).permit(:description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date, :tag_ids => [] )
  end
end
