class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :switch_to_buyer, :switch_to_seller, :suspend_user_account, :reverse_user_suspension, :switch, :revoke]

  def index
  	@users = User.excluding_suspended_accounts.search(params[:search]).order(first_name: :asc).uniq
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

    if @user.admin? 
      @user.admin_access_level = :normal_admin
    end

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

     if @user.admin? 
      @user.admin_access_level = :normal_admin
     end


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
  	@buyers = User.all.where(seller: false, admin: false)
  end

  def sellers
  	@sellers = User.all.where(seller: true, admin: false)
  end

  def suspend_user_account
    @user.suspend_account
    
    # disapprove user's shops and/or products
    @user.shops.update_all(approved: false) if @user.shops.any?
    @user.products.update_all(approved: false) if @user.products.any?

    flash[:notice] = "#{@user.first_name}'s account has been suspended"
    redirect_to :back
  end

  def reverse_user_suspension
    @user.reverse_account_suspension
    
    # approves user's shops and/or products
    @user.shops.update_all(approved: true) if @user.shops.any?
    @user.products.update_all(approved: true) if @user.products.any?


    flash[:notice] = "#{@user.first_name}'s account has been restored"
    redirect_to :back
  end

  def suspended_accounts
    @suspended_users = User.suspended_accounts.where(admin: false, admin_access_level: 0)
  end

  def switch #switch admin
    @user.make_admin
    @user.reverse_account_suspension
    redirect_to :back
  end

  def revoke #revoke admin rights
    @user.revoke_admin_rights 
    @user.suspend_account
    redirect_to :back
  end

  def table_of_admins
    @admins = User.where(admin: true, admin_access_level: 2, suspended: false)  
    @revoked_admins = User.where(admin: false, admin_access_level: 1, suspended: true)
  end

 

  private


  def set_user
  	@user = User.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  # 	flash[:alert] = "user record not found"
  # 	redirect_to admin_users_path
  end

  def user_params
  	params.require(:user).permit(:email, :password, :first_name, :phonenumber,
  		:last_name, :username, :fullname, :image, :age, :gender, :admin, :seller, :admin_access_level)
  end
end
