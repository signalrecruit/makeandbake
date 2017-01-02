require 'rails_helper'

RSpec.describe ShopsController, type: :controller do
  
  describe "GET #index" do 
  	context "get index of all shops available" do 
  	  before do	
  	    @shops = 2.times { FactoryGirl.create :user_with_shops }
  	    get :index
  	  end

  	  it "renders index template" do 	
  	  	expect(response).to render_template :index
  	  end

  	  it "return all shops created" do 
  	  	expect(assigns[:shops].size).to eq 2
  	  end
  	end
  end

  describe "GET #my_shops" do 
  	context "get index of all shops belonging to a particular user who is a seller" do 
  	  before do
  	    @user1 = FactoryGirl.create :user, seller: true, admin: false 
  	    @user2 = 2.times { FactoryGirl.create :user_with_shops }
        @user1_shops = 3.times { FactoryGirl.create :shop, user: @user1 }
        sign_in @user1
        get :my_shops
  	  end	

  	  it "should render show template" do 
  	  	expect(response).to render_template :my_shops
  	  end

  	  it "return all shops that belong to @user1" do 
  	  	expect(assigns[:shops].size).to eq 3
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

  	  it "should render show template" do 
  	  	expect(response).to render_template :show
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

  describe "GET #new" do 
  	before do 
  	  @user = FactoryGirl.create :user, admin: false, seller: true
  	  sign_in @user
  	  get :new
  	end

  	it "should render new template" do 
  	  expect(ShopsController).to render_template "new"
  	end
  end


  describe "POST #create" do 
    before do 
      @seller = FactoryGirl.create :user, admin: false, seller: true
      sign_in @seller
    end
    
    context "create shop successfully" do 
      before do 
        @shop_attributes = FactoryGirl.attributes_for :shop, user: @seller
        post :create, { user_id: @seller.id, shop: @shop_attributes }
      end

      it "should create shop" do 
        expect(Shop.count).to eq 1
      end

      it "should return flash message" do 
      	message = "Your shop was created successfully!"
      	expect(flash[:notice]).to eq message
      end

      it "should redirect_to show shop" do 
        expect(ShopsController).to redirect_to Shop.first
      end
    end

    context "failed to create shop" do 
      before do 
        @shop_invalid_attributes = FactoryGirl.attributes_for :shop, user: @seller
        @shop_invalid_attributes[:name] = ""
        post :create, { user_id: @seller.id, shop: @shop_invalid_attributes }
      end

      it "should produce flash message" do
        expect(flash.now[:alert]).to eq "Failed to create shop"
      end

      it "should re-render form" do 
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT/PATCH #update" do 
  	before do 
  	  @user = FactoryGirl.create :user, admin: false, seller: true
  	  @shop = FactoryGirl.create :shop, name: "New Shop", user: @user
  	  sign_in @user 
  	end

  	context "successfully update shop" do 
  	  before do 
  	  	patch :update, { user_id: @user.id, id: @shop.id, shop: { name: "New Shop Update"} }
  	  	@shop.reload
  	  end

  	  it "should return updated shop" do 
  	  	expect(@shop.name).to eq "New Shop Update"
  	  end

  	  it "should redirect to newly updated shop after successful update" do 
  	  	expect(response).to redirect_to @shop
  	  end
  	end
  end

  describe "DELETE #destroy" do 
  	before do 
  	  @user = FactoryGirl.create :user, admin: false, seller: true
  	  @shop = FactoryGirl.create :shop, name: "Useless Shop", user: @user
  	  sign_in @user
  	  delete :destroy, {user_id: @user.id, id: @shop.id }
  	end

  	it "should respond with a flash alert message" do 
  	  message = "do you want to remove this shop? Removing this shop will delete all associated products!"
  	  expect(flash[:alert]).to eq message
  	end

  	it "should redirect to new shop form" do 
  	  expect(ShopsController).to redirect_to new_shop_path
  	end
  end

end
