require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do 
    context "get index of all products" do 
      before do 
        @products = 5.times { FactoryGirl.create :product }
        get :index
      end

      it "should render index template" do
        expect(response).to render_template :index
      end

      it "should return 5 products" do 
        expect(assigns[:products].size).to eq 5
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
        expect(@product.name).to eq "Chocolate Cake"        
      end

      it { should respond_with 200 }
    end 

    context "unsuccessfully" do 
      before do 
        get :show, id: "some product"  
      end

      it "response by redirecting" do 
       expect(response).to redirect_to(root_path)
      end

      it "returns reason for error in json" do
        message = "The record you were looking for could not be found."
        expect(flash[:alert]).to eq message
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
        post :create, { user_id: @user.id, shop_id: @shop.id, product: @product_attributes }
      end

      it "should create product" do 
        expect(Product.count).to eq 1
      end

      it "should redirect_to show product" do 
        expect(ProductsController).to redirect_to [@shop, Product.first]
      end
    end

    context "failed to create product" do 
      before do 
        @product_attributes = FactoryGirl.attributes_for :product
        @product_attributes[:name] = ""
        post :create, { shop_id: @shop.id, product: @product_attributes }
      end

      it "should produce flash message" do
        expect(flash.now[:alert]).to eq "Failed to create product"
      end

      it "should re-render form" do 
        expect(response).to render_template("new")
      end
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
        expect(@product.name).to eq "New Chocolate"
      end

      it "should return a flash notice" do 
        expect(flash[:notice]).to eq "product update successful"
      end

      it "should redirect to product index page" do 
        expect(ProductsController).to redirect_to [@shop, @product]
      end

      context "unsuccessfully update of product" do
        before do 
          patch :update, { user_id: @user.id, shop_id: @shop.id, id: @product.id, product: { price: "" } }
        end

        it "should return error flash message" do 
          expect(flash.now[:alert]).to eq "product update failed"
        end

        it "should re-render update form" do 
          expect(ProductsController).to render_template("edit")
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
      delete :destroy, { user_id: @user.id, shop_id: @shop.id, id: @product.id }
    end

    it "should redirect to root_path" do 
      expect(ProductsController).to redirect_to products_path
    end
  end


  describe "GET #my_products" do 
    context "return all products to a particular user with a shop" do 
      before do
        @user = FactoryGirl.create :user, admin: false, seller: true
        @shop = FactoryGirl.create :shop, user: @user
        @products = 10.times { FactoryGirl.create :product, shop: @shop }
        @shopless_products = 18.times { FactoryGirl.create :product }
        sign_in @user 
        get :my_products
      end

      it "successfully render my_products template" do 
        expect(response).to render_template :my_products
      end

      it "successfully returns all products belonging to a user with a shop" do 
        expect(assigns[:products].size).to eq 10
      end
    end
  end
end
