class RegistrationsController < Devise::RegistrationsController
  
  def after_sign_up_path_for(resource)
  	if current_user.seller?
      new_shop_path
    else
      products_path
  	end
  end
end
