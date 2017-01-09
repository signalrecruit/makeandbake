require 'rails_helper'

RSpec.describe Product, type: :model do
  before { @product = FactoryGirl.build :product }

  subject { @product }

  @product_attributes = [ :name, :description, :price, :size,  :imageone, :imagetwo, :imagethree, :imagefour, :user_id, :shop_id ]

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
end
