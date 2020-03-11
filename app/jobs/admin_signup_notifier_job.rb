class AdminSignupNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(admin, user)
    NotifyAdminOfUser.notify_admin_of_signup(admin, user).deliver_later
  end
end
