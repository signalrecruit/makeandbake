class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date, presence: true
end
