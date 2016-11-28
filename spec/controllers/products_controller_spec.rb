require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do 
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
    end

    context "failed to create product" do 
      before do 
        @product_attributes = FactoryGirl.attributes_for :product
        @product_attributes[:name] = ""
        post :create, { product: @product_attributes }
      end

      it "should produce flash message" do
        expect(flash[:alert]).to eq "Failed to create product"
      end

      it "should re-render form" do 
        expect(response).to render_template("new")
      end
    end
  end
end
