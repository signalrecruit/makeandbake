class OrdersController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :set_order, only: [:show, :edit, :update, :destroy, :serve_order]
  before_action :authenticate_user!, only: [:prospective_orders]

  def index
  end

  def show
  end

  def new
    if current_user
      @order = current_user.orders.new
    else
  	  @order = Order.new
    end
  end

  def create
    if current_user
      @order = current_user.orders.new(order_params)

      order_with_current_user_detail(current_user)


      if @order.save
        flash[:notice] = "Your order was placed successfully!"
        
        # notify all admin of any order placed
        User.all.where(admin: true).each do |admin|
          OrderNotifierJob.set(wait: 5.seconds).perform_later(admin, @order)
        end
        
        process_order @order

        redirect_to @order
      else
        flash[:alert] = "Your order wasn't placed!"
        render "new"
      end

    else
  	# @order = current_user.orders.new(order_params)
      @order = Order.new(order_params)

      create_user_account(@order)
      @order.user = current_user

  	  if @order.save
  	    flash[:notice] = "Your order was placed successfully!"

        process_order @order

  	    redirect_to @order
  	  else
  	    flash[:alert] = "Your order wasn't placed!"
  	    render "new"
  	  end
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

  def prospective_orders
    @orders = Order.all
  end

  def serve_order
    @order.serve_order(current_user.id)
    byebug
    EstablishInterestInClientJob.set(wait: 5.seconds).perform_later(@order, current_user)
    redirect_to :back
  end

  


  private

  def process_order(order)
    @order_categories = []
    @products_array = [] #contains products that share the same cateogories as order
    @sellers = []  

    # loop to get all the categories that came with this order
    order.tags.each do |category|
      @order_categories << category.name  
    end   
    
    # loop to get all products that share the same categories as order placed
    @order_categories.each do |category|
      @products_array << Product.includes(:tags).where(tags: {name: category})
    end
    
    # loop to get owner of each product, i.e, seller 
    @products_array.each do |products|
      products.each do |product|
        @sellers << User.find(product.user_id)
      end
      
      # and send each seller an email
      @sellers.uniq.each do |seller|
        SellerNotifierJob.set(wait: 5.seconds).perform_later(order, seller)
      end
    end

  end

  def create_user_account(order)
    @user = User.new
    @user.email = order.sender_email
    @user.first_name = order.sender_name
    @user.last_name = "edit last name"
    @user.username = "#{order.sender_name}"
    @user.gender = "edit me"
    @user.phonenumber = order.sender_phonenumber
    @user.age = 0
    @user.password ="password"
    @user.seller = false
    @user.admin = false

    @user.save

    # sign_in @user
    #email user after order is placed
  end

  def order_with_current_user_detail(user)
    @order.sender_name = "#{user.first_name}, #{user.last_name}"
    @order.sender_address = "edit address"
    @order.sender_phonenumber = user.phonenumber
    @order.sender_email = user.email
  end

  def set_order
  	@order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The order you are looking for could not be found"
  	redirect_to root_path
  end

  def order_params
  	params.require(:order).permit(:description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date, :sender_name, :sender_address, :sender_phonenumber, :sender_email, :sample_image, :sample_image_cache, :user_id, :seller_id, :tag_ids => [])
  end
end
