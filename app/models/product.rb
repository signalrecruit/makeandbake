class Product < ActiveRecord::Base
  attr_accessor :tag_names
  has_and_belongs_to_many :tags, uniq: true
  belongs_to :user
  belongs_to :shop

  mount_uploader :imageone, AttachmentUploader
  mount_uploader :imagetwo, AttachmentUploader
  mount_uploader :imagethree, AttachmentUploader
  mount_uploader :imagefour, AttachmentUploader

  validates :name, :description, :price, :size, :imageone, :imagetwo, :imagethree, :imagefour, presence: true  
  validates :price, numericality: { greater_than_or_equal_to: 0, only_float: true }

  def tag_names=(names)
    @tag_names = names

    @tag_names.split(", ").each do |name|
      self.tags << Tag.find_or_initialize_by(name: name) 
      save
    end
  end


  def self.search(search)
    if search
      # where(["lower(name) LIKE ?", "%#{search.downcase}"]) 
      Product.joins(:tags).where(tags: { name: "#{category.downcase}" })
    else
      all
    end	
  end
end
