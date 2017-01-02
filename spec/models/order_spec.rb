require 'rails_helper'

RSpec.describe Order, type: :model do
  
  before { @order = FactoryGirl.build :order }

  subject { @order }

  @order_attributes = [ :description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date, :tag_ids ]

  @order_attributes.each do |attribute|
  	it { should respond_to attribute }
  end

  @order_attributes_to_validate = [:description, :min_price, :max_price, :size, :recipient_address, :recipient_name, :recipient_phonenumber, :recipient_email,
  :delivery_date]

  @order_attributes_to_validate.each do |attribute|
    it { should validate_presence_of attribute }	
  end
  
  [:min_price, :max_price].each do |price_attribute|
    it { should validate_numericality_of(price_attribute).is_greater_than_or_equal_to 0 }
  end

  it { should belong_to :user }
  it { should have_and_belong_to_many :tags }

  it { should be_valid }
end
