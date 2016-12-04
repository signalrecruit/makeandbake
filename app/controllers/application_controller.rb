class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

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


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :fullname, :gender, :image, :seller])
    
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :fullname, :gender, :image, :seller])
  end
end
