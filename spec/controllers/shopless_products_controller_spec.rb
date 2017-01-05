require 'rails_helper'

RSpec.describe ShoplessProductsController, type: :controller do

  describe "GET #index" do 
    context "return all shopless products" do 
  	  before do 	
  	    @shop = FactoryGirl.create :shop
  	    @user = FactoryGirl.create :user, admin: false, seller: true	
        @params = { shop_id: @shop.id }
        sign_in @user
        @shopless_products = 10.times { FactoryGirl.create :product, user: @user, shop: nil }
        get :index, @params
      end

      it "successfully render index template" do
        expect(response).to render_template :index
      end

      it "successfully returns shopless products that belong to @user" do 
        expect(Product.all.where(user_id: @user.id, shop_id: nil).count).to eq 10	
      end
    end
  end
  

  describe "GET #show" do 
  	context "successfully" do 
      before do 
      	@user = FactoryGirl.create :user, seller: true, admin: false
      	@product = FactoryGirl.create :product, name: "shop one", shop: nil
      	sign_in @user
      	get :show, id: @product.id
      end

      it "return requested shop" do 
        expect(assigns[:product].name).to eq "shop one"	
      end

      it "renders show template" do 
        expect(response).to render_template :show
      end
  	end

  	context "unsuccessfully" do 
  	  before do 
  	  	@user = FactoryGirl.create :user, seller: true, admin: false
      	@product = FactoryGirl.create :product, name: "shop one", shop: nil
      	sign_in @user
      	get :show, id: "some id"
  	  end	

  	  it "returns error flash message" do
  	  	message = "The product you were looking for could not be found."
  	  	expect(flash[:alert]).to eq message
  	  end

  	  it "redirects to root path" do 
  	  	expect(response).to redirect_to root_path
  	  end
  	end
  end


  describe "GET #new" do 
    before do 
      @user = FactoryGirl.create :user, seller: true, admin: false
      sign_in @user
    end	 

    context "successfully" do 
      before do
      	get :new
      end	

      it "renders new template" do 
      	expect(response).to render_template :new
      end

      it "returns a new valid product object" do 
        expect(assigns[:product]).to be_a_new(Product)
      end
    end
  end


  describe "POST #create" do 
  	before do 
  	  @user = FactoryGirl.create :user, admin: false, seller: true
  	  sign_in @user
  	end

    context "successfully" do 
      before do 
      	@shopless_product_attributes = FactoryGirl.attributes_for :product, shop_id: nil
      end

      it "shopless product count changes by one" do 
        expect{ post :create, { user_id: @user.id, product: @shopless_product_attributes } 
        }.to change(Product, :count).by(1)
      end

      it "redirect to just created shopless product" do 
      	post :create, { user_id: @user.id, product: @shopless_product_attributes }
        expect(response).to redirect_to shopless_product_path(Product.last)	
      end

      it "returns flash message" do 
        post :create, { user_id: @user.id, product: @shopless_product_attributes }
        message = "Product was successfully created."
        expect(flash[:notice]).to eq message  	
      end
    end

    context "unsuccessfully" do 
      before do 
      	@shopless_product_attributes = FactoryGirl.attributes_for :product, shop_id: nil
        @shopless_product_attributes[:name] = nil
      end

      it "returns flash message" do 
      	post :create, { user_id: @user.id, product: @shopless_product_attributes  }
      	message = "Failed to create product"
      	expect(flash[:alert]).to eq message
      end

      it "render new template" do 
      	post :create, { user_id: @user.id, product: @shopless_product_attributes  }
      	expect(response).to render_template :new
      end

      it "does not save new shopless product" do 
        expect{ post :create, {user_id: @user.id, product: @shopless_product_attributes } 
        }.not_to change(Product, :count)
      end
    end
  end


  describe "GET #edit" do 
    describe "successfully" do 
      before do 
  	    @user = FactoryGirl.create :user, admin: false, seller: true
  	    sign_in @user
  	    @product = FactoryGirl.create :product, name: "first product", shop_id: nil, user: @user
  	    get :edit, id: @product.id 
  	  end

  	  it "renders edit template" do 
  	    expect(response).to render_template :edit
  	  end
    end
  end


  describe "PUT/PATCH #update" do 
    before do 
  	  @user = FactoryGirl.create :user, admin: false, seller: true
  	  sign_in @user
  	end

  	context "successfully" do 
  	  before do 
  	    @product = FactoryGirl.create :product, name: "first product", shop_id: nil, user: @user
  	    post :update, { user_id: @user.id, id: @product, product: { name: "updated first product" } } 
  	  end
      
      it "returns updated producted" do 
      	expect(assigns[:product].name).to eq "updated first product"
      end

      it "redirects to" do 
      	expect(response).to redirect_to shopless_product_path(@product)
      end

      it "returns flash message" do 
      	message = "product update successful"
      	expect(flash[:notice]).to eq message
      end
  	end


  	context "unsuccessfully" do 
  	  before do 
  	    @product = FactoryGirl.create :product, name: "first product", shop_id: nil, user: @user
  	    post :update, { user_id: @user.id, id: @product, product: { price: "forty-four" } } 
  	  end  	

  	  it "returns error flash message" do 
  	  	message = "product update failed"
  	    expect(flash[:alert]).to eq message	
  	  end

  	  it "renders edit template" do 
  	    expect(response).to render_template :edit	
  	  end
  	end


  	describe "DELETE #destroy" do 
  	  context "successfully" do 
  	    before do 
  	      @user = FactoryGirl.create :user, admin: false, seller: true
  	      sign_in @user  	
  	      @product = FactoryGirl.create :product, shop_id: nil, user: @user 
  	    end

  	    it "redirects to products_path" do 
  	      delete :destroy, id: @product.id	
  	      expect(response).to redirect_to products_path	
  	    end

  	    it "Product.count changes by -1" do 
  	      expect{ delete :destroy, id: @product.id
  	      }.to change(Product, :count).by(-1)
  	    end
  	  end	
  	end


  	describe "GET #add" do 
  	  context "successfully" do 
  	    before do 	
  	      @user = FactoryGirl.create :user, admin: false, seller: true
  	      @shop = FactoryGirl.create :shop, user: @user
  	      @product = FactoryGirl.create :product, user: @user
  	      sign_in @user 
  	    end

  	    it "changes number of products @shop has by one" do
  	      expect{ get :add, id: @product.id, shop_id: @shop.id
  	      }.to change(@shop.products, :count).by(1) 	
  	    end

  	    it "redirects to @shop" do 
  	      get :add, id: @product.id, shop_id: @shop.id
  	      expect(response).to redirect_to shop_path(@shop)
  	    end

  	    it "updates product with shop id" do 
  	      get :add, id: @product.id, shop_id: @shop.id
  	      @product.reload
  	      expect(@product.shop_id).to eq @shop.id	
  	    end
  	  end	
  	end
  end
end
