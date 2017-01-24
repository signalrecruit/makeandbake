class Product < ActiveRecord::Base
  has_and_belongs_to_many :tags, uniq: true
  belongs_to :user
  belongs_to :shop

  mount_uploader :imageone, AttachmentUploader
  mount_uploader :imagetwo, AttachmentUploader
  mount_uploader :imagethree, AttachmentUploader
  mount_uploader :imagefour, AttachmentUploader

  validates :name, :description, :price, :size, :imageone, :imagetwo, :imagethree, :imagefour, presence: true  
  validates :price, numericality: { greater_than_or_equal_to: 0, only_float: true }

  attr_accessor :tag_names

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def tag_names=(names)
    @tag_names = names

    @tag_names.split(", ").each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end


  def self.search(search)
    if search
      where(["lower(name || ' ' || size || ' ' || cast(price as text)) LIKE ?", "%#{search.downcase}%"]) 
      # where(["cast(price as text) LIKE ?", "%#{search}%" ])
      # Product.joins(:tags).where(tags: { name: "%#{search.downcase}%" })
    else
      all
    end	
  end

  def approve
    self.update(approved: true)
    save
  end

  def disapprove
    self.update(approved: false)
    save
  end
end
