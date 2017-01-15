class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!

  layout "admin"

  def index
    @users = User.all.where(admin: false)
    @buyers = User.all.where(admin: false, seller: false)
    @sellers = User.all.where(admin: false, seller: true)
    @products = Product.all.where(approved: true)
    @approved_products = Product.where(approved: true)
    @unapproved_products = Product.where(approved: false)
    @orders = Order.all
    @shops = Shop.all.where(approved: true)
    @shop_owners = User.all.where(admin: false, seller: true).joins(:shops)
    @shopless_owners = User.all.where(admin: false).includes(:shops).where(shops: {user_id: nil})

  end

  private

  def authorize_admin!
  	authenticate_user!

  	unless current_user.admin?
  	  flash[:alert] = "Unauthorized action!! You must be admin to proceed."	
  	  redirect_to root_path	
  	end
  end
end
