require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do 
    context "get index of all products" do 
      before do 
        @products = 5.times { FactoryGirl.create :product }
        get :index
      end

      it "should return 5 products" do 
        expect(@products).to eq 5
      end
    end
  end

  describe "GET #show" do
    before { @product = FactoryGirl.create :product, name: "Chocolate Cake", description: "lovely chocolate covering",
     price: 50.00 }

    context "successfully" do 
      before do 
        get :show, id: @product.id
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
        message = "The product you were looking for could not be found."
        expect(flash[:alert]).to eq message
      end
    end
  end

  describe "POST #create" do 
    
    context "create product successfully" do 
      before do 
        @product_attributes = FactoryGirl.attributes_for :product
        post :create, { product: @product_attributes }
      end

      it "should create product" do 
        expect(Product.count).to eq 1
      end

      it "should redirect_to show product" do 
        expect(ProductsController).to redirect_to Product.first
      end
    end

    context "failed to create product" do 
      before do 
        @product_attributes = FactoryGirl.attributes_for :product
        @product_attributes[:name] = ""
        post :create, { product: @product_attributes }
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
    before { @product = FactoryGirl.create :product, name: "flat cake" }

    context "successfully update product" do 
      before do
        patch :update, { id: @product.id, product: { name: "New Chocolate"} }
        @product.reload
      end

      it "should return updated product" do 
        expect(@product.name).to eq "New Chocolate"
      end

      it "should return a flash notice" do 
        expect(flash[:notice]).to eq "product update successful"
      end

      it "should redirect to product index page" do 
        expect(ProductsController).to redirect_to products_path
      end

      context "unsuccessfully update of product" do
        before do 
          patch :update, { id: @product.id, product: { price: "" } }
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
end
