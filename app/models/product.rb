class Product < ActiveRecord::Base
  belongs_to :user

  mount_uploader :imageone, AttachmentUploader
  mount_uploader :imagetwo, AttachmentUploader
  mount_uploader :imagethree, AttachmentUploader
  mount_uploader :imagefour, AttachmentUploader

  validates :name, :description, :price, presence: true  
end
