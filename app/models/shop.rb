class Shop < ActiveRecord::Base
  mount_uploader :image, ShopImageUploader
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :name, :description, :location, :opening, :closing, :user_id, presence: true


  def approve
  	self.update(approved: true)
  	save
  end

  def disapprove
  	self.update(approved: false)
  	save
  end
end
