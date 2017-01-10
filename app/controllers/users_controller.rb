class UsersController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :switch_to_buyer, :switch_to_seller]
  before_action :authenticate_user!, only: [:show, :switch_to_buyer, :switch_to_seller]

  def show
  end

  def switch_to_buyer
    @user.switch_to_buyer
    flash[:notice] = "you are now a buyer"
    redirect_to user_profile_path(@user)
  end

  def switch_to_seller
    @user.switch_to_seller
    flash[:notice] = "you are now a seller"
    redirect_to user_profile_path(@user)
  end
  
  def finish_signup(resource)
  	@user = current_user
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to root_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end