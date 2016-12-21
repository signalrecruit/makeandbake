class Product < ActiveRecord::Base
  attr_accessor :tag_names
  has_and_belongs_to_many :tags, uniq: true
  belongs_to :user
  belongs_to :shop

  mount_uploader :imageone, AttachmentUploader
  mount_uploader :imagetwo, AttachmentUploader
  mount_uploader :imagethree, AttachmentUploader
  mount_uploader :imagefour, AttachmentUploader

  validates :name, :description, :price, :size, presence: true  

  def tag_names=(names)
    @tag_names = names

    names.split(", ").each do |name|
      self.tags << Tag.find_or_initialize_by(name: name) 
    end
  end


  def self.search(search)
    if search
      where(["lower(name) LIKE ?", "%#{search.downcase}"]) 
    else
      all
    end	
  end
end
