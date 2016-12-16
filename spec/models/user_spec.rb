require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build :user }

  subject { @user }

  @user_attributes = [:email, :password, :password_confirmation, :first_name, :last_name, :username, :fullname, :image, :age, :gender, :admin, :seller]

  it { should be_valid }

  #response to user attributes
  @user_attributes.each do |attribute|
  	it { should respond_to attribute }
  end


  # validation specs
  @validated_attributes = [:email, :gender, :age, :username, :phonenumber]

  @validated_attributes.each do |attribute|
    it { should validate_presence_of attribute }
  end

  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:username) }
  it { should validate_confirmation_of :password  }

  # test association

  it { should have_many(:products) }
  it { should have_many(:shops) }


  describe "test association" do
    before { @user = FactoryGirl.create :user, admin: false, seller: true }
    context "with products" do 
      before do 
        products = 5.times { FactoryGirl.create :product, user: @user }
      end

      it "raise error for dependent destroy" do 
        products = @user.products

        @user.destroy

        products.each do |product|
          expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context "with shops" do 
      before do 
        @shops = 2.times { FactoryGirl.create :shop, user: @user }
      end

      it "raises error for dependent destroy" do 
        shops = @user.shops

        @user.destroy

        shops.each do |shop|
          expect(Shop.find(shop)).to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
