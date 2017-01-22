class ServerError < ApplicationMailer
  default from: "MakeAndBake"
  # layout "makeandbake"
  layout false
  
  def server_error_notifier(admin)
    @admin = admin
    mail(to: @admin.email, subject: "Server Temporarily Down")
  end
end
