class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!

  layout "admin"

  def index
  end

  private

  def authorize_admin!
  	authenticate_user!

  	unless current_user.admin?
  	  flash[:alert] = "Unauthorized action!! You must be admin to proceed."	
  	  redirect_to root_path	
  	end
  end
end
