class WelcomeUserJob < ActiveJob::Base
  queue_as :default

  def perform(user, admin)
  	@admin = admin
  	@user = user
  	WelcomeUser.welcome_email(@user, @admin).deliver_later
  end
end
