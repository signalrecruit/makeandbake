class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date, presence: true
  validates :min_price, :max_price, numericality: { greater_than_or_equal_to: 0, only_float: true }

end
