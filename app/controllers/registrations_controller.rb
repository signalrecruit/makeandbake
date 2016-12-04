class RegistrationsController < Devise::RegistrationsController
  
  def after_sign_up_path_for(resource)
  	if current_user.seller?
      new_product_path
    else
      products_path
  	end
  end

  def finish_signup(resource)
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end
end
