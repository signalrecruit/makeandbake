class EstablishInterestInClientJob < ActiveJob::Base
  queue_as :default

  def perform(order, user)
    @order = order
    @seller = user
    InterestInClient.establish_interest(@order, @seller).deliver_later
  end
end
