class Shop < ActiveRecord::Base
  mount_uploader :image, ShopImageUploader
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :name, :description, :location, :opening, :closing, :user_id, presence: true

  # for seo-friendly urls
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def approve
  	self.update(approved: true)
  	save
  end

  def disapprove
  	self.update(approved: false)
  	save
  end

  def self.search(search)
    if search
      where(["lower(name || ' ' || location) LIKE ?", "%#{search.downcase}%"]) 
    else
      all
    end 
  end
end
