class Shop < ActiveRecord::Base
  mount_uploader :image, ShopImageUploader
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :name, :description, :location, :opening, :closing, :user_id, presence: true
end
