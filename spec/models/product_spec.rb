require 'rails_helper'

RSpec.describe Product, type: :model do
  before { @product = FactoryGirl.build :product }

  subject { @product }

  @product_attributes = [:name, :description, :price ]

  @product_attributes.each do |attribute|
  	it { should respond_to attribute }
  end

  @product_attributes.each do |attribute|
    it {should validate_presence_of attribute }
  end

  it { should belong_to :user }
  it { should have_and_belong_to_many :tags }
end
