class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  
  def after_sign_up_path_for(resource)
  	if current_user.seller?
      flash[:notice] = "#{current_user.first_name}, welcome to MakeAndBake"
      
      # send welcome email to user after sign up
      WelcomeUserJob.set(wait: 5.seconds).perform_later(current_user)

      new_shop_path
    elsif current_user.admin?
      admin_root_path    
    elsif !current_user.seller?

      # send welcome email to user after sign up
      WelcomeUserJob.set(wait: 5.seconds).perform_later(current_user)
      
      products_path
  	end
  end



  def after_update_path_for(resource)
    user_profile_path(resource)
  end

  private 

  def check_captcha
  	unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
    end
  end
end
