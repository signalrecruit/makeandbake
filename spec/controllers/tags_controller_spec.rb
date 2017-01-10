# require 'rails_helper'

# RSpec.describe TagsController, type: :controller do
#   before do 
#     FactoryGirl.create :product_with_tags
#     @tags = Tag.all
#     @tag = @tags.first
#     @product = Product.first	
#   end


#   describe "DELETE #remove tag" do 
#     context "successfully" do 
#       it "should redirect to product show page" do 
#         delete :remove, id: @tag.id, product_id: @product.id
#       	expect(response).to redirect_to product_path(@product)
#       end

#       it "should return one less number of tags" do 
#       	expect{ delete :remove, id: @tag.id, product_id: @product.id
#           }.to change(@product.tags, :count).by(-1)
#       end	
#     end
#   end
# end

