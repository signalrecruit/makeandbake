require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do 
    context "get index of all products" do 
      before do 
        5.times { FactoryGirl.create :product }
        @products = Product.all
        get :index
      end

      it "should render index template" do
        expect(response).to render_template :index
      end

      it "should return 5 products" do 
        expect(assigns[:products].size).to eq 5
      end

      it "returns all products in ascending order based on created_at" do
        expect(assigns[:products]).to eq @products.order(price: :asc)  
      end
    end
  end


  describe "GET #show" do
    before do
      @shop = FactoryGirl.create :shop
      @product = FactoryGirl.create :product, name: "Chocolate Cake", description: "lovely chocolate covering", shop: @shop,
      price: 50.00 
    end

    context "successfully" do 
      before do 
        get :show, shop_id: @shop.id, id: @product.id
      end

      it "response to render show template" do 
        expect(response).to render_template :show
      end

      it "returns product" do 
        expect(assigns[:product].name).to eq "Chocolate Cake"        
      end
    end 

    context "unsuccessfully" do 
      before do 
        get :show, id: "some product"  
      end

      it "response by redirecting" do 
       expect(response).to redirect_to root_path
      end

      it "returns reason for error in json" do
        message = "The shop you were looking for could not be found."
        expect(flash[:alert]).to eq message
      end
    end
  end

  describe "GET #new" do 
    context "when @shop is present" do 
      before do 
        @user = FactoryGirl.create :user, admin: false, seller: true
        @shop = FactoryGirl.create :shop, user: @user
        sign_in @user
        get :new, shop_id: @shop.id   
      end

      it "renders new product form" do 
        expect(response).to render_template :new
      end

      it "returns @shop object" do 
        expect(assigns[:shop]).to eq @shop
      end

      it "returns a new product object" do 
        expect(assigns[:product]).to be_a_new(Product)  
      end

      it "returns a new product that belong to @shop" do 
        expect(assigns[:product].shop_id).to eq @shop.id
      end
    end
  end


  describe "POST #create" do 
    before do 
      @shop = FactoryGirl.create :shop
      @user = FactoryGirl.create :user, first_name: "owner1", admin: false, seller: true
      sign_in @user
    end
    
    context "create product successfully" do 
      before do 
        @product_attributes = FactoryGirl.attributes_for :product
      end

      it "should create product" do 
        expect{ post :create, { user_id: @user.id, shop_id: @shop.id, product: @product_attributes }
        }.to change(Product, :count).by(1)
      end

      it "should redirect_to show product" do 
        post :create, { user_id: @user.id, shop_id: @shop.id, product: @product_attributes }
        expect(response).to redirect_to [@shop, Product.first]
      end

      it "product returned belongs to @shop" do
        post :create, { user_id: @user.id, shop_id: @shop.id, product: @product_attributes }
        expect(assigns[:product].shop_id).to eq @shop.id
      end

      it "returns success flash message" do 
        post :create, { user_id: @user.id, shop_id: @shop.id, product: @product_attributes }
        message = "Product was successfully created."
        expect(flash[:notice]).to eq message
      end
    end

    context "failed to create product" do 
      before do 
        @product_attributes = FactoryGirl.attributes_for :product
        @product_attributes[:name] = ""
      end

      it "does not save product" do 
        expect{ post :create, { shop_id: @shop.id, product: @product_attributes }
        }.not_to change(Product, :count)  
      end

      it "should produce flash message" do
        post :create, { shop_id: @shop.id, product: @product_attributes }
        expect(flash.now[:alert]).to eq "Failed to create product"
      end

      it "should re-render form" do 
        post :create, { shop_id: @shop.id, product: @product_attributes }
        expect(response).to render_template :new
      end
    end
  end


  describe "GET #edit" do 
    before do 
      @shop = FactoryGirl.create :shop
      @user = FactoryGirl.create :user, first_name: "owner2", admin: false, seller: true
      sign_in @user
      @product = FactoryGirl.create :product, name: "flat cake", shop: @shop, user: @user 
      get :edit, shop_id: @shop.id, id: @product.id 
    end

    it "render edit template" do 
      expect(response).to render_template :edit
    end

    it "returns valid @shop object for edit form" do 
      expect(assigns[:shop]).to be_valid
    end

    it "returns valid @product for edit form" do 
      expect(assigns[:shop].products.first).to be_valid
    end
  end


  describe "PUT/PATCH #update" do 
    before do 
      @shop = FactoryGirl.create :shop
      @user = FactoryGirl.create :user, first_name: "owner2", admin: false, seller: true
      sign_in @user
      @product = FactoryGirl.create :product, name: "flat cake", shop: @shop
    end
    

    context "successfully update product" do 
      before do
        patch :update, { user_id: @user.id, shop_id: @shop, id: @product.id, product: { name: "New Chocolate"} }
        @product.reload
      end

      it "should return updated product" do 
        expect(assigns[:product].name).to eq "New Chocolate"
      end

      it "should return a flash notice" do 
        expect(flash[:notice]).to eq "product update successful"
      end

      it "should redirect to product index page" do 
        expect(response).to redirect_to [@shop, @product]
      end

      context "unsuccessfully update of product" do
        before do 
          patch :update, { user_id: @user.id, shop_id: @shop.id, id: @product.id, product: { price: "" } }
        end

        it "should return error flash message" do 
          expect(flash.now[:alert]).to eq "product update failed"
        end

        it "should re-render update form" do 
          expect(response).to render_template :edit
        end
      end
    end
  end


  describe "DELETE #destroy" do 
    before do
      @shop = FactoryGirl.create :shop
      @user = FactoryGirl.create :user, admin: false, seller: true
      sign_in @user
      @product = FactoryGirl.create :product, shop: @shop 
    end

    it "should redirect to root_path" do 
      delete :destroy, { user_id: @user.id, shop_id: @shop.id, id: @product.id }
      expect(response).to redirect_to products_path
    end

    it "reduce Product.count by 1" do 
      expect{ delete :destroy, { user_id: @user.id, shop_id: @shop.id, id: @product.id }
      }.to change(Product, :count).by(-1)
    end
  end


  describe "GET #my_products" do 
    context "when user has shops" do 
      before do
        @user = FactoryGirl.create :user, admin: false, seller: true
        @shop = FactoryGirl.create :shop, user: @user
        @products = 10.times { FactoryGirl.create :product, shop: @shop, user: @user }
        sign_in @user 
        get :my_products
      end

      it "successfully render my_products template" do 
        expect(response).to render_template :my_products
      end

      it "successfully returns all 10 products belonging to a user with a shop" do 
        expect(assigns[:products].size).to eq 10
      end
    end

    context "user has no shop" do 
      before do
        @user = FactoryGirl.create :user, admin: false, seller: true
        @shopless_products = 18.times { FactoryGirl.create :product, user: @user, shop: nil  }
        sign_in @user 
        get :my_products
      end

      it "successfully returns all 18 products belonging to a user with a shop" do 
        expect(assigns[:products].size).to eq 18
      end

      it "successfully render my_products template" do 
        expect(response).to render_template :my_products
      end
    end
    
    # yet to be implemented
    # context "user have some products belonging to @shop, some not" do 
    #    before do
    #     @user = FactoryGirl.create :user, admin: false, seller: true
    #     @shop = FactoryGirl.create :shop, user: @user
    #     @products = 10.times { FactoryGirl.create :product, shop: @shop, user: @user }
    #     @shopless_products = 18.times { FactoryGirl.create :product, user: @user, shop: nil  }
    #     sign_in @user 
    #     get :my_products
    #   end  

    #   it "successfully render my_products template" do 
    #     expect(response).to render_template :my_products
    #   end

    #   it "successfully returns all 28 products belonging to a user with a shop" do 
    #     expect(assigns[:products].size).to eq 28
    #   end
    # end
  end

  describe "GET #categorization" do 
    before do 
      FactoryGirl.create :tag_with_products, name: "alien cake" 
      5.times { FactoryGirl.create :tag_with_products, name: "strange cake" }
      params = { category: "Alien Cake" }
      get :categorization, params
    end

    it "render categorization template" do 
      expect(response).to render_template :categorization
    end

    it "returns 4 products with the tag= Alien Cake" do 
      expect(assigns[:products].count).to eq 2
    end
  end
end
