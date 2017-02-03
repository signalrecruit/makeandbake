class ErrorsController < ApplicationController
  layout false

  def not_found
    render(:status => 404)
  end

  def internal_server_error
    User.all.where(admin: true).each do |admin|
  	  ServerErrorNotifierJob.set(wait: 5.seconds).perform_later(admin)
  	end

    render(:status => 500)
  end
end
