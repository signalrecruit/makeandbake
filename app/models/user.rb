class User < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :products, dependent: :destroy
  	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :gender, :age, :username, presence: true
  validates :username, uniqueness: true
end
