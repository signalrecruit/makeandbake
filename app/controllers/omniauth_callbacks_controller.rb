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

  [:twitter, :facebook, :linked_in, :instagram].each do |provider|
    provides_callback_for provider
  end


  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource

      if current_user
        flash[:notice] ="#{current_user.first_name}, welcome to MakeAndBake"
        
        # send welcome email to user after sign up
        WelcomeUserJob.set(wait: 5.seconds).perform_later(current_user)
        
        # notify all admin
      User.all.where(admin: true).each do |admin|
        NotifyAdminOfUserJob.set(wait: 5.seconds).perform_later(admin, current_user)
      end
      end
    else
      # finish_signup_path(resource)
      new_user_registration_url
    end
  end 
end
