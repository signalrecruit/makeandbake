class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  
  def after_sign_up_path_for(resource)
  	if current_user.seller?
      new_shop_path
    else
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
