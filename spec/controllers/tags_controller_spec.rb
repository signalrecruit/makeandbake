require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  before do 
    FactoryGirl.create :product_with_tags
    @tags = Tag.all
    @tag = @tags.first
    @product = Product.first	
  end


  describe "DELETE #remove tag" do 
    context "successfully" do 
      before do 
        delete :remove, id: @tag.id, product_id: @product.id
      end

      it "should redirect to product show page" do 
      	expect(response).to redirect_to product_path(@product)
      end

      it "should return one less number of tags" do 
      	expect(@product.tags.count).to eq 1
      end	
    end
  end
end

