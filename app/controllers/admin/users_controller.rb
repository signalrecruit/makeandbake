class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :switch_to_buyer, :switch_to_seller]

  def index
  	@users = User.all.where(admin: false)
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save 
  	  flash[:notice] = "user successfully created!"
  	  redirect_to [:admin, @user]
  	else
  	  flash[:alert] = "user creation failed!"
  	  render "new"	
  	end
  end

  def edit
  end

  def update
  	
    params[:user].delete(:password) if params[:user][:password].blank?

  	if @user.update(user_params)
  	  flash[:notice] = "user update successful!"
  	  redirect_to [:admin, @user]
  	else
  	  flash[:alert] = "user update failed!"
  	  render "edit"
  	end
  end

  def destroy
  	@user.destroy
  	flash[:notice] = "user deleted successfully!"
  	redirect_to admin_users_path
  end

  def switch_to_buyer
    @user.switch_to_buyer
    flash[:notice] = "you are now a buyer"
    redirect_to [:admin, @user]
  end

  def switch_to_seller
    @user.switch_to_seller
    flash[:notice] = "you are now a seller"
    redirect_to [:admin, @user]
  end

  def buyers
  	@buyers = User.all.where(seller: false)
  end

  def sellers
  	@sellers = User.all.where(seller: true)
  end

  def suspend_user
  end

  def reverse_user_suspension
  end



  private


  def set_user
  	@user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	flash[:alert] = "user record not found"
  	redirect_to admin_users_path
  end

  def user_params
  	params.require(:user).permit(:email, :password, :first_name, :phonenumber,
  		:last_name, :username, :fullname, :image, :age, :gender, :admin, :seller)
  end
end
