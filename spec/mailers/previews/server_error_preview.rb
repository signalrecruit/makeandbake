# Preview all emails at http://localhost:3000/rails/mailers/server_error
class ServerErrorPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/server_error/server_error_notifier
  def server_error_notifier
    ServerError.server_error_notifier
  end

end
