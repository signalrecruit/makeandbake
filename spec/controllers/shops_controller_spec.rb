require 'rails_helper'

RSpec.describe ShopsController, type: :controller do
  
  describe "GET #index" do 
  	context "get index of all shops available" do 
  	  before do	
  	    @user = FactoryGirl.create :user, admin: false, seller: true
        2.times { FactoryGirl.create :shop, user: @user }
        @user = User.last
  	    get :index
  	  end

  	  it "renders index template" do 	
  	  	expect(response).to render_template :index
  	  end

  	  it "return all shops created" do 
  	  	expect(assigns[:shops].size).to eq 2
  	  end

      it "return ascending order based on created_at" do 
        @shops = @user.shops
        @shop1 = @user.shops.first
        @shop2 = @user.shops.last

        expect(assigns[:shops].order(created_at: :asc)).to match_array([@shop2, @shop1])
      end
  	end
  end


  describe "GET #my_shops" do 
  	context "get index of all shops belonging to a particular user who is a seller" do 
  	  before do
  	    @user1 = FactoryGirl.create :user, first_name: "user1", seller: true, admin: false 
        @user2 = FactoryGirl.create :user, first_name: "user2", seller: true, admin: false
  	    2.times { FactoryGirl.create :shop, user: @user2 }
        4.times { FactoryGirl.create :shop, user: @user1 }
        @user1_shops = @user1.shops.order(created_at: :asc)
        sign_in @user1
        get :my_shops
  	  end	

  	  it "should render show template" do 
  	  	expect(response).to render_template :my_shops
  	  end

  	  it "return all 3 shops that belong to @user1" do 
  	  	expect(assigns[:shops].size).to eq 4
  	  end  

      it "return shops that ONLY belongs to @user1" do 
        expect(assigns[:shops]).to eq @user1_shops
      end	  
  	end
  end


  describe "GET #show" do 

  	context "a particular shop successfully" do 
  	  before do
  	  	@user = FactoryGirl.create :user
  	  	@shop = FactoryGirl.create :shop, name: "New Cake", user: @user
        sign_in @user
  	  	get :show, id: @shop.id
  	  end

  	  it "should render show template" do 
  	  	expect(response).to render_template :show
  	  end

  	  it "return shop" do 
  	  	expect(@shop.name).to eq "New Cake"
  	  end

      it "returns products that belongs to @shop ONLY" do 
        5.times { FactoryGirl.create :product, shop_id: @shop, user_id: @user }
        expect(assigns[:shop].products).to eq Product.all.where(shop_id: @shop.id)
      end
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
  	  expect(response).to render_template :new
  	end

    it "returns a new shop object for shop form" do 
      expect(assigns[:shop]).to be_a_new(Shop)  
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
      end

      it "should create shop" do 
        expect{ post :create, { user_id: @seller.id, shop: @shop_attributes }
        }.to change(Shop, :count).by(1)
      end

      it "should return flash message" do 
        post :create, { user_id: @seller.id, shop: @shop_attributes }
      	message = "Your shop was created successfully!"
      	expect(flash[:notice]).to eq message
      end

      it "should redirect_to show shop" do 
        post :create, { user_id: @seller.id, shop: @shop_attributes }
        expect(response).to redirect_to Shop.first
      end
    end

    context "failed to create shop" do 
      before do 
        @shop_invalid_attributes = FactoryGirl.attributes_for :shop, user: @seller
        @shop_invalid_attributes[:name] = ""
      end

      it "should not create shop" do 
        expect{ post :create, { user_id: @seller.id, shop: @shop_invalid_attributes }
        }.not_to change(Shop, :count)
      end

      it "should produce flash message" do
        post :create, { user_id: @seller.id, shop: @shop_invalid_attributes }
        expect(flash.now[:alert]).to eq "Failed to create shop"
      end

      it "should re-render form" do 
        post :create, { user_id: @seller.id, shop: @shop_invalid_attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do 
    before do 
      @user = FactoryGirl.create :user, admin: false, seller: true
      @shop = FactoryGirl.create :shop, name: "New Shop", user: @user
      sign_in @user 
      get :edit, id: @shop.id
    end

    it "render edit form" do 
      expect(response).to render_template :edit
    end

    it "returns @shop object for edit form" do 
      expect(assigns[:shop]).to eq @shop
    end

    it "returns valid @shop object" do 
      expect(assigns[:shop]).to be_valid
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
  	  	expect(assigns[:shop].name).to eq "New Shop Update"
  	  end

  	  it "should redirect to newly updated shop after successful update" do 
  	  	expect(response).to redirect_to @shop
  	  end

      it "should return success flash message" do 
        message = "Your shop was successfully updated!"
        expect(flash[:notice]).to eq message
      end
  	end

    context "unsuccessfully" do
      before do
        patch :update, { user_id: @user.id, id: @shop.id, shop: { name: nil } }
        @shop.reload
      end

      it "return error flash message" do 
        message = "Your failed to update your shop"
        expect(flash[:alert]).to eq message
      end

      it "render edit template" do 
        expect(response).to render_template :edit
      end
    end
  end


  describe "DELETE #destroy" do 
  	before do 
  	  @user = FactoryGirl.create :user, admin: false, seller: true
  	  @shop = FactoryGirl.create :shop, name: "Useless Shop", user: @user
  	  sign_in @user
  	end

  	it "should respond with a flash alert message" do 
      delete :destroy, {user_id: @user.id, id: @shop.id }
  	  message = "do you want to remove this shop? Removing this shop will delete all associated products!"
  	  expect(flash[:alert]).to eq message
  	end

  	it "should redirect to new shop form" do 
      delete :destroy, {user_id: @user.id, id: @shop.id }
  	  expect(response).to redirect_to new_shop_path
  	end

    it "reduce number of shops in total by -1" do 
      expect{ delete :destroy, {user_id: @user.id, id: @shop.id }
      }.to change(Shop, :count).by(-1)
    end
  end
end
