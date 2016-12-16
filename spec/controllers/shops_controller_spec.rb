require 'rails_helper'

RSpec.describe ShopsController, type: :controller do
  
  describe "GET #index" do 
  	context "get index of all shops available" do 
  	  before do	
  	    @shops = 2.times { FactoryGirl.create :user_with_shops }
  	    get :index
  	  end

  	  it "return all shops created" do 
  	  	expect(Shop.count).to eq 2
  	  end
  	end
  end

  describe "GET #my_shop" do 
  	context "get index of all shops belonging to a particular user who is a seller" do 
  	  before do
  	    @user1 = FactoryGirl.create :user, seller: true, admin: false 
  	    @user2 = 2.times { FactoryGirl.create :user_with_shops }
        @user1_shops = 3.times { FactoryGirl.create :shop, user: @user1 }
        get :my_shops
  	  end	

  	  it "return all shops that belong to @user1" do 
  	  	expect(@user1.shops.count).to eq 3
  	  end

  	  it "return all shops" do 
  	  	expect(Shop.count).to eq 5
  	  end
  	end
  end

  describe "GET #show" do 

  	context "a particular shop successfully" do 
  	  before do
  	  	@user = FactoryGirl.create :user
  	  	@shop = FactoryGirl.create :shop, name: "New Cake", user: @user
  	  	get :show, id: @shop.id
  	  end

  	  it "return shop" do 
  	  	expect(@shop.name).to eq "New Cake"
  	  end

 	  it { should respond_with 200 }
  	end

  	context "a particular shop unsuccessfully" do 
  	  before do 
  	  	get :show, id: "some-shop"
  	  end

  	  it "respond by redirecting" do 
  	  	expect(response).to redirect_to(root_path)
  	  end

  	  it "returns flash message for error" do
  	    message = "sorry, could not find the record you are looking for." 
  	  	expect(flash[:alert]).to eq message
  	  end
  	end
  end


   describe "POST #create" do 
    before do 
      @user = FactoryGirl.create :user, admin: false, seller: true
      sign_in @user
    end
    
    context "create shop successfully" do 
      before do 
        @shop_attributes = FactoryGirl.attributes_for :shop
        post :create, { user_id: @user.id, shop: @shop_attributes }
      end

      it "should create shop" do 
        expect(Shop.count).to eq 1
      end

      it "should redirect_to show shop" do 
        expect(ShopsController).to redirect_to Shop.first
      end
    end

    context "failed to create shop" do 
      before do 
        @shop_attributes = FactoryGirl.attributes_for :shop
        @shop_attributes[:name] = ""
        post :create, { user_id: @user.id, shop: @shop_attributes }
      end

      it "should produce flash message" do
        expect(flash.now[:alert]).to eq "Failed to create shop"
      end

      it "should re-render form" do 
        expect(response).to render_template("new")
      end
    end
  end
end
