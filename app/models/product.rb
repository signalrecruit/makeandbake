class Product < ActiveRecord::Base
  has_many :attachments, dependent: :destroy
  # mount_uploader :file, AttachmentUploader

  validates :name, :description, :price, presence: true  
end
