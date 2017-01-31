class EstablishInterestInClientJob < ActiveJob::Base
  queue_as :default

  def perform(order, seller)
    @order = order
    @seller = seller
    InterestInClient.establish_interest(@order, @seller).deliver_later
  end
end
