require 'rails_helper'

RSpec.describe Shop, type: :model do
  before { @shop = FactoryGirl.create :shop }

  subject { @shop }

  @shop_attributes = [:name, :description, :location, :opening, :closing, :image, :user_id]

  #response specs for shop attributes
  @shop_attributes.each do |attribute|
  	it { should respond_to attribute }
  end

  @valid_attributes = [:name, :description, :location, :opening, :closing, :user_id]


  #validation specs
  @valid_attributes.each do |attribute|
  	it { should validate_presence_of attribute }
  end


  #association specs
  it { should belong_to(:user) }
  it { should have_many(:products) }

  it { should be_valid }

  #test associations

  describe "#test associations with products" do 
  	before do
  	  @user = FactoryGirl.create :user_with_shops
  	  @shop = @user.shops.first
  	  5.times { FactoryGirl.create :product, shop: @shop }
  	end

  	it "should raise error for depenedend destroy" do 
  	  @products = @shop.products
  	  	
      @shop.destroy

       @products.each do |product|
      	expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
      end
  	end
  end
end
