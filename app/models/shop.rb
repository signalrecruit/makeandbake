class Shop < ActiveRecord::Base
  mount_uploader :image, ShopImageUploader
  belongs_to :user

  validates :name, :description, :location, :opening, :closing, :image, presence: true
end
