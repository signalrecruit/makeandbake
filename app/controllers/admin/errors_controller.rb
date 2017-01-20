class Admin::ErrorsController < ApplicationController
  layout false 

  def not_found
    render(:status => 404)
    redirect_to admin_errors_not_found_path
  end

  def internal_server_error
    render(:status => 500)
    redirect_to admin_errors_internal_server_error_path
  end
end
