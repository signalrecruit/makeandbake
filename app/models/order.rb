class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  validates :description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date, :sender_name, :sender_address, :sender_phonenumber, :sender_email, presence: true
  validates :min_price, :max_price, numericality: { greater_than_or_equal_to: 0, only_float: true }

 def to_param
    "#{self.id}-#{self.tags.first.name.parameterize}"
 end

 def serve_order(seller_id)
   self.update(seller_id: seller_id )
 end

end
