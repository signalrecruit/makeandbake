require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

 describe "GET #show" do
    before do 
      @user = FactoryGirl.create :user, seller: true, admin: false
      @tag = FactoryGirl.create :tag, name: "Chocolate Vanilla flavor"
      @order = FactoryGirl.create :order, user: @user, tag_ids: [@tag.id]
      sign_in @user
    end

   context "successfully" do 
     before do 
       get :show, id: @order.id
     end

     it "should render show template" do 
       expect(response).to render_template :show
     end

     it "should return order with tag name => Chocolate Vanilla flavor" do 
       expect(@order.tags.first.name).to eq "Chocolate Vanilla flavor"
     end

     it "should assign requested order to @order" do 
       expect(assigns[:order]).to eq @order
     end
   end 

   context "unsuccessfully" do 
     before do 
       get :show, id: "wrong-id"
     end

     it "should redirect to root path" do 
       expect(response).to redirect_to root_path
     end

     it "should show flash message" do 
       message = "The order you are looking for could not be found"
       expect(flash[:alert]).to eq message
     end
   end
 end


 describe "GET #new" do 
   before do 
     @user = FactoryGirl.create :user
     sign_in @user
     get :new
   end

   it "should render order form" do 
     expect(response).to render_template :new
   end

   it "returns a new order object" do 
     expect(assigns[:order]).to be_a_new(Order)
   end
 end

 
 describe "POST #create" do 
   before do 
     @user = FactoryGirl.create :user
     @order_attributes = FactoryGirl.attributes_for :order
     sign_in @user 
   end

   context "successfully" do 
     it "should change Order count by one" do 
       expect{
        post :create, { user_id: @user.id, order: @order_attributes }
       }.to change(Order, :count).by(1)
     end 

     it "should redirect to @contact after successful save" do
       post :create, { user_id: @user.id, order: @order_attributes }
       expect(response).to redirect_to Order.last
     end

     it "returns success flash message" do 
       post :create, { user_id: @user.id, order: @order_attributes }
       message = "Your order was placed successfully!"
       expect(flash[:notice]).to eq message
     end
   end

   context "unsuccessfully" do 
     before do 
       @invalid_attributes = FactoryGirl.attributes_for :order
       @invalid_attributes[:recipient_email] = " "
     end

     it "should not save new order" do 
       expect{
        post :create, { user_id: @user.id, order: @invalid_attributes }
       }.not_to change(Order, :count)
     end

     it "should redirect to new template" do 
       post :create,  { user_id: @user.id, order: @invalid_attributes }
       expect(response).to render_template :new
     end
   end   
 end

 describe "GET #edit" do 
   before do 
     @user = FactoryGirl.create :user
     @order = FactoryGirl.create :order, user: @user
     sign_in @user
     get :edit, id: @order
   end

   it "should render edit template" do 
     expect(response).to render_template :edit
   end

   it "returns a valid order object" do 
     expect(assigns[:order]).to be_valid
   end
 end

 describe "PUT/PATCH #update" do 
   before do 
     @user = FactoryGirl.create :user
     @order = FactoryGirl.create :order, user: @user, recipient_email: "first@recipient.com"
     sign_in @user
   end

   context "successfully update order" do 
     before do 
       put :update, { user_id: @user.id, id: @order.id, order: { recipient_email: "updated@recipient.com"  } }
       @order.reload
     end

     it "returns update order" do 
       expect(assigns[:order].recipient_email).to eq "updated@recipient.com"
     end

     it "redirects to @order" do 
       expect(response).to redirect_to @order
     end

     it "return flash notice" do 
       message = "Your order was updated successfully!"
       expect(flash[:notice]).to eq message
     end
   end

   context "unsuccessfully" do 
     before do 
        put :update, { user_id: @user.id, id: @order.id, order: { min_price: "forty-five"  } }
       @order.reload
     end

     it "returns error flash messgae" do 
       message = "Your order failed to update!"
       expect(flash[:alert]).to eq message 
     end

     it "re-renders update form" do 
       expect(response).to render_template :edit
     end
   end
 end

 describe "DELETE #destroy" do 
   before do 
     @user = FactoryGirl.create :user 
     @order = FactoryGirl.create :order, user: @user 
     sign_in @user   
   end

   it "successfully destroys @order record" do 
     expect{ delete :destroy, user_id: @user.id, id: @order.id
     }.to change(Order, :count).by(-1)
   end

   it "redirects to order form" do 
     delete :destroy, user_id: @user.id, id: @order.id
     expect(response).to redirect_to new_order_path
   end

   it "render a flash notice" do 
     delete :destroy, user_id: @user.id, id: @order.id
     message = "Your order was successfully deleted!" 
     expect(flash[:notice]).to eq message 
   end
 end
end
