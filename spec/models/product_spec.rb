require 'rails_helper'

RSpec.describe Product, type: :model do
  before { @product = FactoryGirl.build :product }

  subject { @product }

  @product_attributes = [:name, :description, :price, :size,  :imageone, :imagetwo, :imagethree, :imagefour, :user_id, :shop_id, :approved]

  @product_attributes.each do |attribute|
  	it { should respond_to attribute }
  end

  @validate_attributes = [ :name, :description, :price, :size ]

  # image validation 
  describe "validate all four images" do 
    before do 
      @product.imageone = File.open(Rails.root.join("spec/fixtures/cake1.jpg"))
      @product.imagetwo = File.open(Rails.root.join("spec/fixtures/cake2.jpg"))
      @product.imagethree = File.open(Rails.root.join("spec/fixtures/cake3.jpg"))
      @product.imagefour = File.open(Rails.root.join("spec/fixtures/cake4.jpg"))
    end

    context "product should have mutiple images" do 
      it "imageone should be present" do 
        expect(@product.imageone).to be_present
      end

      it "imagetwo should be present" do 
        expect(@product.imagetwo).to be_present
      end

      it "imagethree should be present" do 
        expect(@product.imagethree).to be_present
      end

      it "imagefour should be present" do 
        expect(@product.imagefour).to be_present
      end
    end
  end


  @validate_attributes.each do |attribute|
    it {should validate_presence_of attribute }
  end

  it { should validate_numericality_of(:price).is_greater_than_or_equal_to 0 }

  it { should belong_to :user }
  it { should belong_to :shop }
  it { should have_and_belong_to_many :tags }

  it { should be_valid }

  context "Product Search" do 
    before do 
      @user = FactoryGirl.create :user
      @shop = FactoryGirl.create :shop, user: @user, approved: true
      @product1 = FactoryGirl.create :product, name: "Chocolate Cake", size: "medium", price: 45.99, user: @user, shop: @shop, approved: true
      @product2 = FactoryGirl.create :product, name: "Strawberry Cake",  size: "medium", price: 34.00, user: @user, shop: @shop, approved: true
      @product3 = FactoryGirl.create :product, name: "Vanilla Cake", size: "large", price: 55.00, user: @user, shop: @shop,approved: true
      @product4 = FactoryGirl.create :product, name: "Cupcakes", size: "small", price: 44.00, user: @user, shop: @shop, approved: true
      @product5 = FactoryGirl.create :product, name: "Pancakes", size: "small", price: 22.99, user: @user, shop: @shop, approved: true
    end

    it "returns product1" do 
      search_params = { size: "medium" }
      expect(Product.where(approved: true).search(search_params.to_s.downcase)).to match_array([1])
    end
  end
end
