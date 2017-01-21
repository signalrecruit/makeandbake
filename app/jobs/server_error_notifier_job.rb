class ServerErrorNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(admin)
    @admin = admin
    ServerError.server_error_notifier(@admin).deliver_later  
  end
end
