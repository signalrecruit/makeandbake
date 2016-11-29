class Product < ActiveRecord::Base
  has_many :attachments, dependent: :destroy
  belongs_to :user

  mount_uploader :imageone, AttachmentUploader
  mount_uploader :imagetwo, AttachmentUploader
  mount_uploader :imagethree, AttachmentUploader
  mount_uploader :imagefour, AttachmentUploader

  validates :name, :description, :price, presence: true  
end
