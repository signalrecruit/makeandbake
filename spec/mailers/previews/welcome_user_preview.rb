# Preview all emails at http://localhost:3000/rails/mailers/welcome_user
class WelcomeUserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome_user/welcome_email
  def welcome_email
    WelcomeUser.welcome_email
  end

end
