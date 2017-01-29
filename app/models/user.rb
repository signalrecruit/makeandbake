class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  enum admin_access_level: [:not_admin, :revoked_admin, :normal_admin, :super_admin]
  
  scope :suspended_accounts, lambda { where(suspended: true, admin: false, admin_access_level: 0) }
  scope :excluding_suspended_accounts, lambda { where(suspended: false, admin: false, admin_access_level: 0) }

  mount_uploader :image, ImageUploader
  mount_uploader :twitter_image, ImageUploader


  has_many :products, dependent: :destroy
  has_many :shops, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :identities, dependent: :destroy
  	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :gender, :username, :phonenumber, presence: true
  validates :username, uniqueness: true
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :phonenumber, format: { with: /\A[-+]?[0-9]*\.?[0-9]+\Z/, message: "only allows numbers" }




   def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      # email = auth.info.email if email_is_verified
      email = auth.info.email || auth.extra.raw_info.email
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          # twitter_image: auth.extra.raw_info.profile_image_url,
          phonenumber: "0000000000",
          fullname: auth.extra.raw_info.name || auth.info.name || "user-#{auth.uid}",
          username: auth.info.nickname || auth.extra.raw_info.username || "username",
          first_name: auth.extra.raw_info.first_name || "first name here",
          last_name: auth.extra.raw_info.last_name || "last name here",
          # email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          email: auth.info.email || auth.extra.raw_info.email || "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          gender: auth.extra.raw_info.gender || "female", 
          seller: false,
          # password: Devise.friendly_token[0,20]
          password: "password"
        )
        # user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def switch_to_buyer
    self.update(seller: false)
    save
  end

  def switch_to_seller
    self.update(seller: true)
    save
  end

  def self.search(search)
    if search
      where(["lower(first_name || ' ' || last_name || ' ' || age || ' ' || email) LIKE ?", "%#{search.downcase}%"]) 
    else
      all
    end 
  end

  def suspend_account
    self.update(suspended: true)
    save  
  end

  def reverse_account_suspension
    self.update(suspended: false)
    save
  end

  def make_admin
    self.update(admin: true, admin_access_level: :normal_admin)
    save
  end

  def revoke_admin_rights
    self.update(admin: false, admin_access_level: :revoked_admin)
    save
  end

  def active_for_authentication?
    super && !suspended?
  end

  def inactive_message
    suspended? ? :suspended_user : super
  end
end
