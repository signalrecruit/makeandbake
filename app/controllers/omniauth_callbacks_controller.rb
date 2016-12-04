class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
   def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :facebook, :linked_in].each do |provider|
    provides_callback_for provider
  end


  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      # finish_signup_path(resource)
      # new_user_registration_url
      @user = current_user
      if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to root_url, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
        redirect_to new_user_registration_url
      end
    end
    end
  end 
end
