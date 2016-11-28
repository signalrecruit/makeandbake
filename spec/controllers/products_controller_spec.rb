require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

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

end
