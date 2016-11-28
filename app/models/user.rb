class User < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, :gender, :age, :username, presence: true
  validates :username, uniqueness: true
end
