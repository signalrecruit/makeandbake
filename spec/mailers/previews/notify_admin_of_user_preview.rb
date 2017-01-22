# Preview all emails at http://localhost:3000/rails/mailers/notify_admin_of_user
class NotifyAdminOfUserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notify_admin_of_user/notify_admin_of_signup
  def notify_admin_of_signup
    NotifyAdminOfUser.notify_admin_of_signup
  end

end
