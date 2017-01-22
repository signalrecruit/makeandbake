class AdminSignupNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(admin, user)
    @admin = admin
    @user = user
    NotifyAdminOfUser.notify_admin_of_signup(@admin, @user).deliver_later
  end
end
