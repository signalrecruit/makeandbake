class WelcomeUserJob < ActiveJob::Base
  queue_as :default

  def perform(user)
  	@user = user
  	WelcomeUser.welcome_email(@user).deliver_later
  end
end
