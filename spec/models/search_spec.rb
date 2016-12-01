require 'rails_helper'

RSpec.describe Search, type: :model do
  before { @search = FactoryGirl.build :search }

  subject { @search }

  it { should be_valid }

  # test validation
  @search_attributes = [:keywords, :name, :min_price, :max_price]

  @search_attributes.each do |attribute|
  	it { should respond_to attribute }
  end


  describe ".search_products" do 
  	before do 
      @search1 = FactoryGirl.create :search, keywords: "eye cake", min_price: 30.0, max_price: 100.0
      @search2 = FactoryGirl.create :search, keywords: "chocolate cake", min_price: 50.0, max_price: 70.0
      @search3 = FactoryGirl.create :search, keywords: "juice", min_price: 22.0, max_price: 23.0
      @search4 = FactoryGirl.create :search, keywords: "", min_price: 30.0, max_price: 88.0
      @product1 = FactoryGirl.create :product, name: "eye cake", price: 34.0
      @product2 = FactoryGirl.create :product, name: "chocolate cake", price: 69.0
      @product3 = FactoryGirl.create :product, name: "vanilla cake", price: 100.0
  	end


    context "when keyword is eye cake and min_price is 30.0 and max_price is 100.00" do 
      it "should return product 1" do 
      	expect(@search1.search_products).to match_array([@product1])
      end
    end

    context "when keyword is chocolate cake, min_price is 50.0, max_price is 70.0" do 
      it "should return product 2" do 
        expect(@search2.search_products).to match_array([@product2])
      end
    end

    context "when keyword is juice, min_price 22.0, max_price is 23.0" do 
      it "should return an empty array" do 
        expect(@search3.search_products).to be_empty
      end	
    end

    context "when keywords is blank, min_price is 30.0, max_price is 88.0" do 
      it "should return product 1 and product 2" do 
      	expect(@search4.search_products).to match_array([@product1, @product2])
      end
    end


  end
end
