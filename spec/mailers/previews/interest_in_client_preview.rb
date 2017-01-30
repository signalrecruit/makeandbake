# Preview all emails at http://localhost:3000/rails/mailers/interest_in_client
class InterestInClientPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/interest_in_client/establish_interest
  def establish_interest
    InterestInClient.establish_interest
  end

end
